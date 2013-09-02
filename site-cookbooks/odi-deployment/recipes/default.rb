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
  include ODI::Deployment::Helpers
end

deploy_root = node[:deployment][:root]
domain      = get_domain

[
    deploy_root,
    "/etc/nginx/sites-enabled"
].each do |dir|
  directory dir do
    action :create
    recursive true
  end
end

mysql_ip = find_a 'mysql'

dbi = data_bag_item node['databags']['primary'], 'databases'

precompile_assets = node[:deployment][:precompile_assets].nil? ? true : node[:deployment][:precompile_assets]
port              = node[:deployment][:port]
root_dir          = "%s/%s" % [
    deploy_root,
    node[:project_fqdn]
]

make_shared_dirs root_dir

deploy_revision root_dir do
  user node[:user]
  group node[:user]

  environment(
      "RACK_ENV" => node[:deployment][:rack_env],
      "HOME"     => "/home/%s" % [
          user
      ]
  )

  keep_releases 10
  rollback_on_error true
  migrate           = node.has_key? :migrate
  migration_command = node[:migrate]

  revision node[:deployment][:revision]

  repo "git://github.com/theodi/%s.git" % [
      node[:git_project]
  ]

  before_migrate do
    current_release_directory = release_path
    running_deploy_user       = new_resource.user
    shared_directory          = new_resource.shared_path
    bundler_depot             = new_resource.shared_path + '/bundle'

    begin
      mysql_password = dbi[node[:database]][node.chef_environment]
    rescue
      mysql_password = 'ThisPasswordIntentionallyLeftBlank'
    end

    {
        'database.yml' => {
            :mysql_host     => mysql_ip,
            :mysql_database => node[:database],
            :mysql_username => node[:database],
            :mysql_password => mysql_password
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
          --without=development test\
          --quiet \
          --path #{bundler_depot}
      EOF
    end

    script 'Precompiling assets' do
      interpreter 'bash'
      cwd current_release_directory
      user running_deploy_user
      code <<-EOF
        RAILS_ENV=#{node[:deployment][:rack_env]} bundle exec rake assets:precompile
      EOF
      only_if { precompile_assets }
    end
  end

  before_restart do
    current_release_directory = release_path
    running_deploy_user       = new_resource.user

    foremanise node[:git_project] do
      cwd current_release_directory
      user running_deploy_user
      port port
    end

    template "%s/vhost" % [
        current_release_directory
    ] do
      source "vhost.erb"
      variables(
          :servername    => node[:git_project],
          :port          => node[:deployment][:port],
          :domain        => domain,
          :static_assets => precompile_assets
      )
      action :create
    end

    link "/etc/nginx/sites-enabled/%s" % [
        node[:project_fqdn]
    ] do
      to "%s/vhost" % [
          current_release_directory
      ]
    end
  end

  restart_command "sudo service %s restart" % [
      node[:git_project]
  ]
  notifies :restart, "service[nginx]"

  action :deploy

end

