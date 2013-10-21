#
# Cookbook Name:: rs_monitoring
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

if node["rackspace"]
  include_recipe "cloud_monitoring::default"
  include_recipe "cloud_monitoring::agent"

  hostname = node.hostname.gsub("-", "_")

  node.set['cloud_monitoring']['agent']['id'] = hostname

  cloud_monitoring_entity "#{hostname}" do
    ip_addresses 'default' => node[:ipaddress]
    rackspace_auth_url "https://lon.identity.api.rackspacecloud.com/v2.0"
    metadata 'environment' => 'production'
    action :create

    notifies :restart, "service[rackspace-monitoring-agent]"
  end

  cloud_monitoring_check "ping" do
    target_alias 'default'
    type 'remote.ping'
    period 30
    timeout 10
    monitoring_zones_poll [
                              'mzord',
                              'mzdfw',
                              'mzlon'
                          ]
    action :create
  end

  cloud_monitoring_alarm "ping alarm" do
    check_label 'ping'
    example_id 'remote.ping_packet_loss'
    notification_plan_id 'npTechnicalContactsEmail'
    action :create
  end
end