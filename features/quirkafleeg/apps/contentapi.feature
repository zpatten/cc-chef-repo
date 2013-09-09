@quirkafleeg @apps @contentapi
Feature: GDS apps
  In order to run Quirkafleeg
  I need to run contentapi

  Background:
    * I ssh to "web-quirkafleeg-01" with the following credentials:
      | username | keyfile |
      | $lxc$    | $lxc$   |

  Scenario: contentapi exists
    * directory "/var/www/contentapi" should exist
    And directory "/var/www/contentapi/shared" should exist
    And directory "/var/www/contentapi/shared/log" should exist
    And directory "/var/www/contentapi/shared/log" should be owned by "quirkafleeg:quirkafleeg"

  Scenario: env is all good
    * file "/home/quirkafleeg/env" should exist
    And symlink "/var/www/contentapi/current/.env" should exist
    When I run "cat /var/www/contentapi/current/.env"
    Then I should see "RACKSPACE_USERNAME: rax" in the output
    And I should see "RACKSPACE_DIRECTORY_ASSET_HOST: http://3c1" in the output
    And I should see "JENKINS_URL: http://jenkins.theodi.org" in the output
    And I should see "GOVUK_ASSET_ROOT: static.quirkafleeg.info" in the output
    And I should see "DEV_DOMAIN: quirkafleeg.info" in the output
    And I should see "GOVUK_APP_DOMAIN: quirkafleeg.info" in the output
    And I should see "GDS_SSO_STRATEGY: real" in the output

  Scenario: startup scripts be all up in it
    * file "/etc/init/contentapi.conf" should exist
    And file "/etc/init/contentapi-thin.conf" should exist
    And file "/etc/init/contentapi-thin-1.conf" should exist
    When I run "cat /etc/init/contentapi-thin-1.conf"
    Then I should see "exec su - quirkafleeg -c 'cd /var/www/contentapi/releases/" in the output
    And I should see "export PORT=7000" in the output
    And I should see "bundle exec thin start -p \$PORT >> /var/log/quirkafleeg/contentapi/thin-1.log 2>&1" in the output

  Scenario: contentapi vhost exists
    * file "/var/www/contentapi/current/vhost" should exist

  Scenario: contentapi vhost is correct
    And file "/var/www/contentapi/current/vhost" should contain
    """
upstream contentapi {
  server 127.0.0.1:7000;
}

server {
  listen 8080;
  server_name contentapi.quirkafleeg.info;
  access_log /var/log/nginx/contentapi.log;
  error_log /var/log/nginx/contentapi.err;

  location / {
    try_files $uri @backend;
  }

  location @backend {
    proxy_set_header X-Forwarded-Proto 'http';
    proxy_set_header Host $server_name;
    proxy_pass http://contentapi;
  }
}
    """

  Scenario: contentapi vhost is symlinked
    And symlink "/etc/nginx/sites-enabled/contentapi" should exist

   Scenario: mongoid conf file is correct
    * file "/var/www/contentapi/shared/config/mongoid.yml" should exist
    And file "/var/www/contentapi/shared/config/mongoid.yml" should contain
    """
production:
  host: 192.168.99.10
  port: 27017
  username:
  password:
  database: govuk_content_publisher
  use_activesupport_time_zone: true
    """
    And symlink "/var/www/contentapi/current/config/mongoid.yml" should exist
    And symlink "/var/www/contentapi/current/mongoid.yml" should exist
