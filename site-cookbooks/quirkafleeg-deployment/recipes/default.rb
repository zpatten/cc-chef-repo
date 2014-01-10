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
domain      = get_domain
env_extras

[
    deploy_root,
    "/etc/nginx/sites-enabled"
].each do |dir|
  directory dir do
    action :create
    recursive true
  end
end

dbi = data_bag_item node['databags']['primary'], 'databases'

#mysql_ip = ''
if dbi['host']
  mysql_ip = dbi['host']
else
  mysql_ip = find_a 'mysql'
end

mongo_ip = find_a 'mongo'

node['apps'].each_pair do |github_name, attributes|
  deploy_name = github_name

  if attributes['deploy_name'] then
    deploy_name = attributes['deploy_name']
  end

#  precompile_assets = !attributes.has_key?(:precompile_assets) and true
  precompile_assets = attributes[:precompile_assets].nil? ? true : attributes[:precompile_assets]
  assets_path       = attributes[:assets_path].nil? ? 'assets' : attributes[:assets_path]
  port              = attributes['port']
  root_dir          = "%s/%s" % [
      deploy_root,
      deploy_name
  ]

  make_shared_dirs root_dir

  deploy_revision root_dir do
    user node['user']
    group node['user']

    environment "RACK_ENV"         => node['deployment']['rack_env'],
                "HOME"             => "/home/#{user}",
                "GOVUK_APP_DOMAIN" => node['govuk']['app_domain']

    keep_releases 10
    rollback_on_error true
    migrate           = node.has_key? :migrate
    migration_command = node[:migrate]

    revision node['deployment']['revision']

    repo "git://github.com/theodi/%s.git" % [
        github_name
    ]

    before_migrate do
      current_release_directory = release_path
      running_deploy_user       = new_resource.user
      shared_directory          = new_resource.shared_path
      bundler_depot             = new_resource.shared_path + '/bundle'

      begin
        mysql_password = dbi[attributes['mysql_db']][node.chef_environment]
      rescue
        mysql_password = 'ThisPasswordIntentionallyLeftBlank'
      end

      {
          'database.yml' => {
              :mysql_host     => mysql_ip,
              :mysql_database => attributes[:mysql_db],
              :mysql_username => attributes[:mysql_db],
              :mysql_password => mysql_password
          },
          'mongoid.yml'  => {
              :mongoid_host     => mongo_ip,
              :mongoid_port     => 27017,
              :mongoid_database => attributes['mongo_db']
          }
      }.each_pair do |name, params|
        template '%s/config/%s' % [
            shared_directory,
            name
        ] do
          source "%s.erb" % [
              name
          ]
          variables(
              params
          )
          user node['user']
          group node['user']
          mode "0644"
          action :create
        end

        db_conf_symlink name do
          shared_dir shared_directory
          current_dir current_release_directory
        end
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
        GOVUK_APP_DOMAIN=#{domain} RAILS_ENV=#{node['deployment']['rack_env']} bundle exec rake assets:precompile
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
            :servername         => deploy_name,
            :port               => port,
            :domain             => domain,
            :static_assets      => precompile_assets,
            :assets_path        => assets_path,
            :listen_port        => node[:nginx][:listen_port],
            :default            => attributes[:is_default],
            :redirects          => attributes[:redirects],
            :naked_domain       => attributes[:naked_domain],
            :aliases            => attributes[:aliases],
            :non_odi_hostname   => attributes[:non_odi_hostname],
            :catch_and_redirect => attributes[:catch_and_redirect]
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

    restart_command "sudo service #{deploy_name} restart"
    notifies :restart, "service[nginx]"

#    if node['ipaddress'] =~ /192.168/ then
#      action :force_deploy
#    else
#      notifies :restart, "service[#{deploy_name}]", :delayed
    action :deploy
#    end
#    action :force_deploy
  end
end

