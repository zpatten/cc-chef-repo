@quirkafleeg @apps @signon
Feature: GDS apps
  In order to run Quirkafleeg
  I need to run signonatron

  Background:
    * I ssh to "backend-quirkafleeg-01" with the following credentials:
      | username | keyfile |
      | $lxc$    | $lxc$   |

  Scenario: signon exists
    * directory "/var/www/signon" should exist
    And directory "/var/www/signon/shared" should exist
    And directory "/var/www/signon/shared/log" should exist
    And directory "/var/www/signon/shared/log" should be owned by "quirkafleeg:quirkafleeg"

  Scenario: Assets have been compiled
    * directory "/var/www/signon/current/public/assets/" should exist

  @env
  Scenario: env is all good
    * file "/home/quirkafleeg/env" should exist
    And symlink "/var/www/signon/current/.env" should exist
    When I run "cat /var/www/signon/current/.env"
    Then I should see "RACKSPACE_USERNAME: rax" in the output
    And I should see "RACKSPACE_DIRECTORY_ASSET_HOST: http://3c1" in the output
    And I should see "JENKINS_URL: http://jenkins.theodi.org" in the output
    And I should see "GOVUK_ASSET_ROOT: static.theodi.org" in the output
    And I should see "DEV_DOMAIN: theodi.org" in the output
    And I should see "GOVUK_APP_DOMAIN: theodi.org" in the output
    And I should see "GDS_SSO_STRATEGY: real" in the output

  Scenario: startup scripts be all up in it
    * file "/etc/init/signon.conf" should exist
    And file "/etc/init/signon-thin.conf" should exist
    And file "/etc/init/signon-thin-1.conf" should exist
    When I run "cat /etc/init/signon-thin-1.conf"
    Then I should see "exec su - quirkafleeg -c 'cd /var/www/signon/releases/" in the output
    And I should see "export PORT=4000" in the output
    And I should see "bundle exec thin start -p \$PORT >> /var/log/quirkafleeg/signon/thin-1.log 2>&1" in the output

  Scenario: signon vhost exists
    * file "/var/www/signon/current/vhost" should exist

  @vhost
  Scenario: signon vhost is correct
    And file "/var/www/signon/current/vhost" should contain
    """
upstream signon {
  server 127.0.0.1:4000;
}

server {
  listen 80 default;
  server_name signon.theodi.org sign-in.theodi.org sign-on.theodi.org;
  access_log /var/log/nginx/signon.log;
  error_log /var/log/nginx/signon.err;
  root /var/www/signon/current/public/;

  location / {
    try_files $uri @backend;
  }

  location ~ ^/(assets)/ {
    gzip_static on; # to serve pre-gzipped version
    expires max;
    add_header Cache-Control public;
  }

  location @backend {
    proxy_set_header X-Forwarded-Proto 'http';
    proxy_set_header Host $server_name;
    proxy_pass http://signon;
  }
}
    """

  @mysqlconf
  Scenario: mysql conf is correct
    * file "/var/www/signon/shared/config/database.yml" should exist
    And file "/var/www/signon/shared/config/database.yml" should contain
    """
production:
  adapter: mysql2
  database: signon
  username: signon
  password: superawesomefakepassword
  host: 192.168.99.20
    """
    And symlink "/var/www/signon/current/config/database.yml" should exist
    And symlink "/var/www/signon/current/database.yml" should exist
