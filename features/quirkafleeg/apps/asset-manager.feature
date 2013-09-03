@quirkafleeg @apps @asset-manager
Feature: GDS apps
  In order to run Quirkafleeg
  I need to run asset-manager

  Background:
    * I ssh to "web-quirkafleeg-01" with the following credentials:
      | username | keyfile |
      | $lxc$    | $lxc$   |

  Scenario: asset-manager exists
    * directory "/var/www/asset-manager" should exist
    And directory "/var/www/asset-manager/shared" should exist
    And directory "/var/www/asset-manager/shared/log" should exist
    And directory "/var/www/asset-manager/shared/log" should be owned by "quirkafleeg:quirkafleeg"

  Scenario: env is all good
    * file "/home/quirkafleeg/env" should exist
    And symlink "/var/www/asset-manager/current/.env" should exist
    When I run "cat /var/www/asset-manager/current/.env"
    Then I should see "RACKSPACE_USERNAME: rax" in the output
    And I should see "RACKSPACE_DIRECTORY_ASSET_HOST: http://3c1" in the output
    And I should see "JENKINS_URL: http://jenkins.theodi.org" in the output
    And I should see "GOVUK_ASSET_ROOT: static.192.168.99.30.xip.io" in the output
    And I should see "DEV_DOMAIN: 192.168.99.30.xip.io" in the output
    And I should see "GOVUK_APP_DOMAIN: 192.168.99.30.xip.io" in the output
    And I should see "GDS_SSO_STRATEGY: real" in the output

  Scenario: startup scripts be all up in it
    * file "/etc/init/asset-manager.conf" should exist
    And file "/etc/init/asset-manager-thin.conf" should exist
    And file "/etc/init/asset-manager-thin-1.conf" should exist
    When I run "cat /etc/init/asset-manager-thin-1.conf"
    Then I should see "exec su - quirkafleeg -c 'cd /var/www/asset-manager/releases/" in the output
    And I should see "export PORT=13000" in the output
    And I should see "bundle exec thin start -p \$PORT >> /var/log/quirkafleeg/asset-manager/thin-1.log 2>&1" in the output

  Scenario: asset-manager vhost exists
    * file "/var/www/asset-manager/current/vhost" should exist

  Scenario: asset-manager vhost is correct
    And file "/var/www/asset-manager/current/vhost" should contain
    """
upstream asset-manager {
  server 127.0.0.1:13000;
}

server {
  listen 8080;
  server_name asset-manager.192.168.99.30.xip.io;
  access_log /var/log/nginx/asset-manager.log;
  error_log /var/log/nginx/asset-manager.err;

  location / {
    try_files $uri @backend;
  }

  location @backend {
    proxy_set_header X-Forwarded-Proto 'http';
    proxy_set_header Host $server_name;
    proxy_pass http://asset-manager;
  }
}
    """

  Scenario: asset-manager vhost is symlinked
    And symlink "/etc/nginx/sites-enabled/asset-manager" should exist

   Scenario: mongoid conf file is correct
    * file "/var/www/asset-manager/shared/config/mongoid.yml" should exist
    And file "/var/www/asset-manager/shared/config/mongoid.yml" should contain
    """
production:
  host: 192.168.99.10
  port: 27017
  username:
  password:
  database: govuk_content_publisher
  use_activesupport_time_zone: true
    """
    And symlink "/var/www/asset-manager/current/config/mongoid.yml" should exist
    And symlink "/var/www/asset-manager/current/mongoid.yml" should exist
