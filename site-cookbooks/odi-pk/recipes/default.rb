#
# Cookbook Name:: odi-pk
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

u = node["generic_user"]

user u do
  shell "/bin/bash"
  home "/home/%s" % [
      u
  ]
  supports :manage_home => true
  action :create
end

file "/etc/sudoers.d/%s" % [
    u
] do
  content "%s ALL=NOPASSWD:ALL" % [
      u
  ]
  mode "0440"
  action :create
end

git "/tmp/public-keys" do
  repository "git://github.com/theodi/public-keys.git"
  action :sync
end

directory "/home/%s/.ssh/" % [
    u
] do
  owner u
  group u
  action :create
end

auth_keys_file = "/home/%s/.ssh/authorized_keys" % [
    u
]

script "build auth_keys" do
  interpreter "bash"
  user u
  code <<-EOF
    rm -f #{auth_keys_file}
    cd /tmp/public-keys/
    for pk in `ls *pub`
    do
      cat ${pk} >> #{auth_keys_file}
      echo "" >> #{auth_keys_file}
    done
  EOF
end

file "/home/%s/.ssh/authorized_keys" % [
    u
] do
  owner u
  group u
  mode "0400"
end