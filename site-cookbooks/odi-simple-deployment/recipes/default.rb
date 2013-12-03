#
# Cookbook Name:: odi-simple-deployment
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

include_recipe 'git'

root_dir = "/var/www/%s" % [
    node['project_fqdn']
]

[
    "",
    "shared",
    "shared/config",
    "shared/log"
].each do |d|
  directory "%s/%s" % [
      root_dir,
      d
  ] do
    owner node['user']
    group node['group']
    action :create
    mode "0775"
    recursive true
  end
end

deploy_revision root_dir do
  user node['user']
  group node['group']
  environment "RACK_ENV" => node['RACK_ENV'],
              "HOME"     => "/home/#{user}"
  keep_releases 10
  rollback_on_error true

  repo "git://github.com/theodi/%s.git" % [
      node['git_project']
  ]

  revision node['deploy']['revision']
  symlink_before_migrate.clear

  before_migrate do
    current_release_directory = release_path
    running_deploy_user       = new_resource.user
    bundler_depot             = new_resource.shared_path + '/bundle'

    script 'Link me some links' do
      interpreter 'bash'
      cwd current_release_directory
      user running_deploy_user
      code <<-EOF
          ln -sf ../../shared/config/env .env
      EOF
    end

    script 'Bundling the gems' do
      interpreter 'bash'
      cwd current_release_directory
      user running_deploy_user
      code <<-EOF
        bundle install \
          --quiet \
          --path #{bundler_depot}
      EOF
    end
  end

  before_restart do
    current_release_directory = release_path
    running_deploy_user       = new_resource.user

    script 'Generate startup scripts with Foreman' do
      interpreter 'bash'
      cwd current_release_directory
      user running_deploy_user
      code <<-EOF
        export rvmsudo_secure_path=1
        /home/#{user}/.rvm/bin/rvmsudo bundle exec foreman export \
          -a #{node['git_project']} \
          -u #{node['user']} \
          -t config/foreman \
          -p 3000 \
          upstart /etc/init
      EOF
    end
  end
  restart_command "sudo service #{node['git_project']} restart"
  action :deploy
end
