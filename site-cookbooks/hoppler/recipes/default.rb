#
# Cookbook Name:: hoppler
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

hoppler = node["hoppler"]["user"]

group "%s" % [
    hoppler
] do
  action :create
end

user "%s" % [
    hoppler
] do
  gid hoppler
  shell "/bin/bash"
  home "/home/%s" % [
      hoppler
  ]
  supports :manage_home => true
  action :create
end

include_recipe "envbuilder"

file "/etc/sudoers.d/%s" % [
    hoppler
] do
  content "%s ALL=NOPASSWD:ALL" % [
      hoppler
  ]
  mode "0440"
  action :create
end

node.set['rvm'] = {} if not node['rvm']
node.set['rvm']['user'] = hoppler
node.set['rvm']['ruby'] = node['hoppler']['ruby']

include_recipe "odi-rvm"

dbi = data_bag_item node['databags']['primary'], 'databases'

node.set['mysql']['server_root_password'] = dbi['root'][node.chef_environment]

git "/home/%s/hoppler" % [
    hoppler
] do
  repository "git://github.com/theodi/hoppler.git"
  user hoppler
  group hoppler
  action :sync
end

directory "/home/%s/hoppler" % [
    hoppler
] do
  mode "0755"
  owner hoppler
  group hoppler
end

template "/home/%s/hoppler/.mysql.env" % [
    hoppler
] do
  source "mysql.env.erb"
  variables(
      :username => "root",
      :password => node['mysql']['server_root_password']
  )
  owner hoppler
  group hoppler
end

link "/home/hoppler/hoppler/.env" do
  to "/home/hoppler/.env"
end

script "bundle" do
  interpreter 'bash'
  code <<-EOF
  su - hoppler -c "cd /home/hoppler/hoppler && bundle update --quiet"
  EOF
end

template "/etc/cron.d/hoppler" do
  source "cron.erb"
  variables(
      :backup_hour  => node["hoppler"]["backup_hour"],
      :backup_minute  => node["hoppler"]["backup_minute"],
      :cleanup_hour => node["hoppler"]["cleanup_hour"],
      :cleanup_day  => node["hoppler"]["cleanup_day"]
  )
end

#dbi = data_bag_item "databases", "credentials"

template "/home/%s/hoppler/db.creds.yaml" % [
  hoppler
] do
  source "db.creds.yaml.erb"
  variables(
      :database => node[:database],
      :password => dbi[node[:database][node.chef_environment]]
  )
  owner hoppler
  group hoppler
end

script "restore some DBs" do
  interpreter "bash"
  code <<-EOF
  su - hoppler -c "cd /home/hoppler/hoppler && rake hoppler:restore"
  EOF
end