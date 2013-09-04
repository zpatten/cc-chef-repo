@quirkafleeg @apps @panopticon
Feature: GDS apps
  In order to run Quirkafleeg
  I need to run panopticon

  Background:
    * I ssh to "web-quirkafleeg-01" with the following credentials:
      | username | keyfile |
      | $lxc$    | $lxc$   |

  Scenario: panopticon exists
    * directory "/var/www/panopticon" should exist
    And directory "/var/www/panopticon/shared" should exist
    And directory "/var/www/panopticon/shared/log" should exist
    And directory "/var/www/panopticon/shared/log" should be owned by "quirkafleeg:quirkafleeg"

  Scenario: Assets have been compiled
    * directory "/var/www/panopticon/current/public/assets/" should exist

  Scenario: env is all good
    * file "/home/quirkafleeg/env" should exist
    And symlink "/var/www/panopticon/current/.env" should exist
    When I run "cat /var/www/panopticon/current/.env"
    Then I should see "RACKSPACE_USERNAME: rax" in the output
    And I should see "RACKSPACE_DIRECTORY_ASSET_HOST: http://3c1" in the output
    And I should see "JENKINS_URL: http://jenkins.theodi.org" in the output
    And I should see "GOVUK_ASSET_ROOT: static.192.168.99.30.xip.io" in the output
    And I should see "DEV_DOMAIN: 192.168.99.30.xip.io" in the output
    And I should see "GOVUK_APP_DOMAIN: 192.168.99.30.xip.io" in the output
    And I should see "GDS_SSO_STRATEGY: real" in the output

  Scenario: startup scripts be all up in it
    * file "/etc/init/panopticon.conf" should exist
    And file "/etc/init/panopticon-thin.conf" should exist
    And file "/etc/init/panopticon-thin-1.conf" should exist
    When I run "cat /etc/init/panopticon-thin-1.conf"
    Then I should see "exec su - quirkafleeg -c 'cd /var/www/panopticon/releases/" in the output
    And I should see "export PORT=5000" in the output
    And I should see "bundle exec thin start -p \$PORT >> /var/log/quirkafleeg/panopticon/thin-1.log 2>&1" in the output

  Scenario: panopticon vhost exists
    * file "/var/www/panopticon/current/vhost" should exist

  Scenario: panopticon vhost is correct
    And file "/var/www/panopticon/current/vhost" should contain
    """
upstream panopticon {
  server 127.0.0.1:5000;
}

server {
  listen 8080;
  server_name panopticon.192.168.99.30.xip.io;
  access_log /var/log/nginx/panopticon.log;
  error_log /var/log/nginx/panopticon.err;

  location / {
    try_files $uri @backend;
  }

  location ~ ^/(assets)/  {
    root /var/www/panopticon/current/public/;
    gzip_static on; # to serve pre-gzipped version
    expires max;
    add_header Cache-Control public;
  }

  location @backend {
    proxy_set_header X-Forwarded-Proto 'http';
    proxy_set_header Host $server_name;
    proxy_pass http://panopticon;
  }
}
    """

  Scenario: panopticon vhost is symlinked
    And symlink "/etc/nginx/sites-enabled/panopticon" should exist

   Scenario: mongoid conf file is correct
    * file "/var/www/panopticon/shared/config/mongoid.yml" should exist
    And file "/var/www/panopticon/shared/config/mongoid.yml" should contain
    """
production:
  host: 192.168.99.10
  port: 27017
  username:
  password:
  database: govuk_content_publisher
  use_activesupport_time_zone: true
    """
    And symlink "/var/www/panopticon/current/config/mongoid.yml" should exist
    And symlink "/var/www/panopticon/current/mongoid.yml" should exist
