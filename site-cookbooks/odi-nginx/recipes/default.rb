#
# Cookbook Name:: odi-nginx
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

package "nginx" do
  action :install
end

[
    '000-default',
    'default'
].each do |f|
  file "/etc/nginx/sites-enabled/%s" % [
      f
  ] do
    action :delete
  end
end

service 'nginx' do
  supports :status => true, :restart => true, :reload => true
  action :enable
end

#ssl = node['nginx']['force_ssl']

#ssl_tag  = nil
#protocol = 'http'
#if ssl
#  ssl_tag  = '.ssl'
#  protocol = 'https'
#end

#prefix = ''
#if node['nginx']['vhost_prefix'] then
#  prefix = "%s." % [
#      node['nginx']['vhost_prefix']
#  ]
#end
#template "/etc/nginx/sites-available/%s%s%s" % [
#    prefix,
#    node["project_fqdn"],
#    ssl_tag
#] do
#
#  port = 80
#  if ssl
#    port = 81
#  end
#
#  fqdn = node["project_fqdn"]
#  if node['nginx']['vhost_prefix'] then
#    fqdn = "%s.%s" % [
#        node['nginx']['vhost_prefix'],
#        fqdn
#    ]
#  end
#
#  source "vhost.erb"
#  variables(
#      :port          => port,
#      :ssl_tag       => ssl_tag,
#      :fqdn          => fqdn,
#      :code_path     => node["project_fqdn"],
#      :project_name  => node["git_project"],
#      :static_assets => node["nginx"]["static_assets"]
#  )
#  action :create
#end

#link "/etc/nginx/sites-enabled/%s%s%s" % [
#    prefix,
#    node["project_fqdn"],
#    ssl_tag
#] do
#  to "/etc/nginx/sites-available/%s%s%s" % [
#      prefix,
#      node["project_fqdn"],
#      ssl_tag
#  ]

#  notifies :restart, "service[nginx]"
#end

#if ssl
#  template "/etc/nginx/sites-available/%s" % [
#      node["project_fqdn"]
#  ] do
#    source "redirect.erb"
#    variables(
#        :this     => node["project_fqdn"],
#        :that     => node["project_fqdn"],
#        :port     => 80,
#        :protocol => protocol,
#        :ssl_tag  => nil
#    )
#  end

#  link "/etc/nginx/sites-enabled/%s" % [
#      node["project_fqdn"]
#  ] do
#    to "/etc/nginx/sites-available/%s" % [
#        node["project_fqdn"]
#    ]

#    notifies :restart, "service[nginx]"
#  end
#end

#if node['nginx']["301_redirects"]
#  node['nginx']["301_redirects"].each do |r|

#    ports = [
#        80
#    ]
#    if ssl
#      ports << 81
#    end

#    ports.each do |port|
#      ssl_tag = nil
#      if port == 81
#        ssl_tag = '.ssl'
#      end
#      template "/etc/nginx/sites-available/%s%s" % [
#          r,
#          ssl_tag
#      ] do
#        source "redirect.erb"
#        variables(
#            :this     => node["project_fqdn"],
#            :that     => r,
#            :port     => port,
#            :protocol => protocol,
#            :ssl_tag  => ssl_tag
#        )
#      end

#      link "/etc/nginx/sites-enabled/%s%s" % [
#          r,
#          ssl_tag
#      ] do
#        to "/etc/nginx/sites-available/%s%s" % [
#            r,
#            ssl_tag
#        ]
#
#        notifies :restart, "service[nginx]"
#      end
#    end
#  end
#end