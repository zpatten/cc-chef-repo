#
# Cookbook Name:: hoppler
# Recipe:: mongo
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

#node.set['rvm'] = {} if not node['rvm']
#node.set['rvm']['user'] = hoppler
#node.set['rvm']['ruby'] = node['hoppler']['ruby']

#include_recipe "odi-rvm"

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

link "/home/%s/hoppler/.env" % [
    hoppler
] do
  to "/home/env/env"
end

#search_string = "chef_environment:%s AND role:mongodb" % [
#    node.chef_environment
#]
#box           = search(:node, search_string)[0]
#mongo_ip        = box['ipaddress']
#if box['rackspace']
#  mongo_ip = box['rackspace']['private_ip']
#end

file "/home/%s/hoppler/.local.env" % [
    hoppler
] do
  content "MONGO_HOST: %s" % [
      "127.0.0.1"
  ]
end

script "bundle" do
  interpreter 'bash'
  code <<-EOF
  su - hoppler -c "cd /home/hoppler/hoppler && rvmsudo bundle update --quiet"
  EOF
end

template "/etc/cron.d/hoppler" do
  source "cron.erb"
  variables(
      :backup_hour    => node["hoppler"]["backup_hour"],
      :backup_minute  => node["hoppler"]["backup_minute"],
      :cleanup_hour   => node["hoppler"]["cleanup_hour"],
      :cleanup_day    => node["hoppler"]["cleanup_day"],
      :backup_command => node["hoppler"]["mongo_backup_command"]
  )
end