#
# Cookbook Name:: odi-mysql
# Recipe:: server
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

dbi = data_bag_item node['databags']['primary'], 'databases'

node.set['mysql']['server_root_password'] = dbi['root'][node.chef_environment]

listen_address = node["ipaddress"]
if node["rackspace"]
  listen_address = node["rackspace"]["private_ip"]
end

node.set['mysql']['bind_address'] = listen_address
node.save

#script "ffs" do
#  interpreter 'bash'
#  code <<-EOF
#echo #{node.set['mysql']['server_root_password']} > /tmp/ffs
#  EOF
#end

include_recipe "mysql::server"