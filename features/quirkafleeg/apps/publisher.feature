@quirkafleeg @apps @publisher
Feature: GDS apps
  In order to run Quirkafleeg
  I need to run publisher

  Background:
    * I ssh to "backend-quirkafleeg-01" with the following credentials:
      | username | keyfile |
      | $lxc$    | $lxc$   |

  Scenario: publisher exists
    * directory "/var/www/publisher" should exist
    And directory "/var/www/publisher/shared" should exist
    And directory "/var/www/publisher/shared/log" should exist
    And directory "/var/www/publisher/shared/log" should be owned by "quirkafleeg:quirkafleeg"

  Scenario: Assets have been compiled
    * directory "/var/www/publisher/current/public/assets/" should exist

  Scenario: env is all good
    * file "/home/quirkafleeg/env" should exist
    And symlink "/var/www/publisher/current/.env" should exist
    When I run "cat /var/www/publisher/current/.env"
    Then I should see "RACKSPACE_USERNAME: rax" in the output
    And I should see "RACKSPACE_DIRECTORY_ASSET_HOST: http://3c1" in the output
    And I should see "JENKINS_URL: http://jenkins.theodi.org" in the output
    And I should see "GOVUK_ASSET_ROOT: static.quirkafleeg.info" in the output
    And I should see "DEV_DOMAIN: quirkafleeg.info" in the output
    And I should see "GOVUK_APP_DOMAIN: quirkafleeg.info" in the output
    And I should see "GDS_SSO_STRATEGY: real" in the output

  Scenario: startup scripts be all up in it
    * file "/etc/init/publisher.conf" should exist
    And file "/etc/init/publisher-thin.conf" should exist
    And file "/etc/init/publisher-thin-1.conf" should exist
    When I run "cat /etc/init/publisher-thin-1.conf"
    Then I should see "exec su - quirkafleeg -c 'cd /var/www/publisher/releases/" in the output
    And I should see "export PORT=4030" in the output
    And I should see "bundle exec thin start -p \$PORT >> /var/log/quirkafleeg/publisher/thin-1.log 2>&1" in the output

  Scenario: publisher vhost exists
    * file "/var/www/publisher/current/vhost" should exist

  Scenario: publisher vhost is correct
    And file "/var/www/publisher/current/vhost" should contain
    """
upstream publisher {
  server 127.0.0.1:4030;
}

server {
  listen 8080;
  server_name publisher.quirkafleeg.info;
  access_log /var/log/nginx/publisher.log;
  error_log /var/log/nginx/publisher.err;

  location / {
    try_files $uri @backend;
  }

  location ~ ^/(assets)/  {
    root /var/www/publisher/current/public/;
    gzip_static on; # to serve pre-gzipped version
    expires max;
    add_header Cache-Control public;
  }

  location @backend {
    proxy_set_header X-Forwarded-Proto 'http';
    proxy_set_header Host $server_name;
    proxy_pass http://publisher;
  }
}
    """

  Scenario: publisher vhost is symlinked
    And symlink "/etc/nginx/sites-enabled/publisher" should exist

   Scenario: mongoid conf file is correct
    * file "/var/www/publisher/shared/config/mongoid.yml" should exist
    And file "/var/www/publisher/shared/config/mongoid.yml" should contain
    """
production:
  host: 192.168.99.10
  port: 27017
  username:
  password:
  database: govuk_content_publisher
  use_activesupport_time_zone: true
    """
    And symlink "/var/www/publisher/current/config/mongoid.yml" should exist
    And symlink "/var/www/publisher/current/mongoid.yml" should exist
