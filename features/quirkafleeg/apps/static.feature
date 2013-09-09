@quirkafleeg @apps @static
Feature: GDS apps
  In order to run Quirkafleeg
  I need to run the static thingy

  Background:
    * I ssh to "web-quirkafleeg-01" with the following credentials:
      | username | keyfile |
      | $lxc$    | $lxc$   |

  Scenario: static exists
    * directory "/var/www/static" should exist
    And directory "/var/www/static/shared" should exist
    And directory "/var/www/static/shared/log" should exist
    And directory "/var/www/static/shared/log" should be owned by "quirkafleeg:quirkafleeg"

  Scenario: Assets have been compiled
    * directory "/var/www/static/current/public/static/" should exist

  Scenario: env is all good
    * file "/home/quirkafleeg/env" should exist
    And symlink "/var/www/static/current/.env" should exist
    When I run "cat /var/www/static/current/.env"
    Then I should see "RACKSPACE_USERNAME: rax" in the output
    And I should see "RACKSPACE_DIRECTORY_ASSET_HOST: http://3c1" in the output
    And I should see "JENKINS_URL: http://jenkins.theodi.org" in the output
    And I should see "GOVUK_ASSET_ROOT: static.quirkafleeg.info" in the output
    And I should see "DEV_DOMAIN: quirkafleeg.info" in the output
    And I should see "GOVUK_APP_DOMAIN: quirkafleeg.info" in the output
    And I should see "GDS_SSO_STRATEGY: real" in the output

  Scenario: startup scripts be all up in it
    * file "/etc/init/static.conf" should exist
    And file "/etc/init/static-thin.conf" should exist
    And file "/etc/init/static-thin-1.conf" should exist
    When I run "cat /etc/init/static-thin-1.conf"
    Then I should see "exec su - quirkafleeg -c 'cd /var/www/static/releases/" in the output
    And I should see "export PORT=4000" in the output
    And I should see "bundle exec thin start -p \$PORT >> /var/log/quirkafleeg/static/thin-1.log 2>&1" in the output

  Scenario: static vhost exists
    * file "/var/www/static/current/vhost" should exist

  Scenario: static vhost is correct
    And file "/var/www/static/current/vhost" should contain
    """
upstream static {
  server 127.0.0.1:4000;
}

server {
  listen 8080;
  server_name static.quirkafleeg.info;
  access_log /var/log/nginx/static.log;
  error_log /var/log/nginx/static.err;

  location / {
    try_files $uri @backend;
  }

  location ~ ^/(static)/  {
    root /var/www/static/current/public/;
    gzip_static on; # to serve pre-gzipped version
    expires max;
    add_header Cache-Control public;
  }

  location @backend {
    proxy_set_header X-Forwarded-Proto 'http';
    proxy_set_header Host $server_name;
    proxy_pass http://static;
  }
}
    """
