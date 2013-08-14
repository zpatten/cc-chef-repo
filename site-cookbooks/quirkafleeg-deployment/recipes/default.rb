#
# Cookbook Name:: quirkafleeg-deployment
# Recipe:: default
#
# Copyright 2013, The Open Data Institute
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#

class Chef::Recipe
  include ODI::Quirkafleeg::Helpers
end

deploy_root = node['deployment']['root']

domain = get_domain

env_extras

directory deploy_root do
  action :create
end

directory "/etc/nginx/sites-enabled" do
  action :create
  recursive true
end

#mongo_server = nil
#mysql_server = nil
#if Chef::Config[:solo] then
#  Chef::Log.warn("This recipe uses search. Chef Solo does not support search.")
#else
#  mongo_server = search(:node, "name:*mongo-#{node[:project]}* AND chef_environment:#{node.chef_environment}")[0]
#  mysql_server = search(:node, "name:*mysql-#{node[:project]}* AND chef_environment:#{node.chef_environment}")[0]
#end

#mongo_ip = mongo_server['ipaddress']
#if mongo_server['rackspace']
#  mongo_ip = mongo_server['rackspace']['private_ip']
#end

#mysql_ip = mysql_server['ipaddress']
#if mysql_server['rackspace']
#  mysql_ip = mysql_server['rackspace']['private_ip']
#end

mysql_ip = find_a 'mysql'
mongo_ip = find_a 'mongo'

dbi = data_bag_item node['databags']['primary'], 'databases'

node['apps'].each_pair do |github_name, attributes|
  deploy_name = github_name
  if attributes['deploy_name'] then
    deploy_name = attributes['deploy_name']
  end

  precompile_assets = true
  if attributes.has_key?(:precompile_assets) then
    precompile_assets = attributes[:precompile_assets]
  end

  port     = attributes['port']
  root_dir = "%s/%s" % [
      deploy_root,
      deploy_name
  ]

  [
      "shared",
      "shared/config",
      "shared/pids",
      "shared/log",
      "shared/system"
  ].each do |d|
    directory "%s/%s" % [
        root_dir,
        d
    ] do
      owner node['user']
      group node['user']
      action :create
      mode "0775"
      recursive true
    end
  end

  deploy_revision root_dir do
    user node['user']
    group node['user']

    environment "RACK_ENV"         => node['deployment']['rack_env'],
                "HOME"             => "/home/#{user}",
                "GOVUK_APP_DOMAIN" => node['govuk']['app_domain']

    keep_releases 10
    rollback_on_error true
#    migrate true

    revision node['deployment']['revision']

    repo "git://github.com/theodi/%s.git" % [
        github_name
    ]

    before_migrate do
      current_release_directory = release_path
      running_deploy_user       = new_resource.user
      shared_directory          = new_resource.shared_path
      bundler_depot             = new_resource.shared_path + '/bundle'

      template '%s/config/mongoid.yml' % [
          new_resource.shared_path
      ] do
        source "mongoid.yml.erb"
        variables(
            :mongoid_host     => mongo_ip,
            :mongoid_port     => 27017,
            :mongoid_database => attributes['mongo_db']
        )
        user node['user']
        group node['user']
        mode "0644"
        action :create
      end

      script 'Symlink mongoid.yml' do
        interpreter 'bash'
        cwd current_release_directory
        user running_deploy_user
        code <<-EOF
        ln -sf #{shared_directory}/config/mongoid.yml mongoid.yml
        ln -sf #{shared_directory}/config/mongoid.yml config/mongoid.yml
        EOF
      end

      begin
        mysql_password = dbi[attributes['mysql_db']][node.chef_environment]
      rescue
        mysql_password = 'derp'
      end

      template '%s/config/database.yml' % [
          shared_directory
      ] do
        source "database.yml.erb"
        variables(
            :mysql_host     => mysql_ip,
            :mysql_database => attributes[:mysql_db],
            :mysql_username => attributes[:mysql_db],
            :mysql_password => mysql_password
        )
        action :create
      end

      script 'Symlink database.yml' do
        interpreter 'bash'
        cwd current_release_directory
        user running_deploy_user
        code <<-EOF
        ln -sf #{shared_directory}/config/database.yml database.yml
        ln -sf #{shared_directory}/config/database.yml config/database.yml
        EOF
      end

      script 'Symlink env' do
        interpreter 'bash'
        cwd current_release_directory
        user running_deploy_user
        code <<-EOF
        ln -sf /home/#{user}/env .env
        EOF
      end

      script 'Bundling' do
        interpreter 'bash'
        cwd current_release_directory
        user running_deploy_user
        code <<-EOF
        bundle install \
          --without=development \
          --quiet \
          --path #{bundler_depot}
        EOF
      end

      script 'Precompiling assets' do
        interpreter 'bash'
        cwd current_release_directory
        user running_deploy_user
        code <<-EOF
          GOVUK_APP_DOMAIN='' RAILS_ENV=#{node['deployment']['rack_env']} bundle exec rake assets:precompile
        EOF
        only_if { precompile_assets }
      end
    end

    before_restart do
      current_release_directory = release_path
      running_deploy_user       = new_resource.user

      foremanise deploy_name do
        cwd current_release_directory
        user running_deploy_user
        port port
      end

      template "%s/vhost" % [
          current_release_directory
      ] do
        source "vhost.erb"
        variables(
            :servername    => deploy_name,
            :port          => port,
            :domain        => domain,
            :static_assets => precompile_assets
        )
        action :create
      end

      link "/etc/nginx/sites-enabled/%s" % [
          deploy_name
      ] do
        to "%s/vhost" % [
            current_release_directory
        ]
      end
    end
    notifies :restart, "service[nginx]"
#    notifies :restart, "service[#{deploy_name}]"

    if node.chef_environment then
      action :force_deploy
    else
      action :deploy
    end
#    action :force_deploy
  end
end

