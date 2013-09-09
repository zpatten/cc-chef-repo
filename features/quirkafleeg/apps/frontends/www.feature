@quirkafleeg @apps @www
Feature: GDS apps
  In order to run Quirkafleeg
  I need to run the www frontend

  Background:
    * I ssh to "web-quirkafleeg-01" with the following credentials:
      | username | keyfile |
      | $lxc$    | $lxc$   |

  Scenario: www exists
    * directory "/var/www/www" should exist
    And directory "/var/www/www/shared" should exist
    And directory "/var/www/www/shared/log" should exist
    And directory "/var/www/www/shared/log" should be owned by "quirkafleeg:quirkafleeg"

  Scenario: Assets have been compiled
    * directory "/var/www/www/current/public/assets/" should exist

  Scenario: env is all good
    * file "/home/quirkafleeg/env" should exist
    And symlink "/var/www/www/current/.env" should exist
    When I run "cat /var/www/www/current/.env"
    Then I should see "RACKSPACE_USERNAME: rax" in the output
    And I should see "RACKSPACE_DIRECTORY_ASSET_HOST: http://3c1" in the output
    And I should see "JENKINS_URL: http://jenkins.theodi.org" in the output
    And I should see "GOVUK_ASSET_ROOT: static.quirkafleeg.info" in the output
    And I should see "DEV_DOMAIN: quirkafleeg.info" in the output
    And I should see "GOVUK_APP_DOMAIN: quirkafleeg.info" in the output
    And I should see "GDS_SSO_STRATEGY: real" in the output

  Scenario: startup scripts be all up in it
    * file "/etc/init/www.conf" should exist
    And file "/etc/init/www-thin.conf" should exist
    And file "/etc/init/www-thin-1.conf" should exist
    When I run "cat /etc/init/www-thin-1.conf"
    Then I should see "exec su - quirkafleeg -c 'cd /var/www/www/releases/" in the output
    And I should see "export PORT=11000" in the output
    And I should see "bundle exec thin start -p \$PORT >> /var/log/quirkafleeg/www/thin-1.log 2>&1" in the output

  Scenario: www vhost exists
    * file "/var/www/www/current/vhost" should exist

  Scenario: www vhost is correct
    And file "/var/www/www/current/vhost" should contain
    """
upstream www {
  server 127.0.0.1:11000;
}

server {
  listen 8080;
  server_name www.quirkafleeg.info;
  access_log /var/log/nginx/www.log;
  error_log /var/log/nginx/www.err;

  location / {
    try_files $uri @backend;
  }

  location ~ ^/(assets)/  {
    root /var/www/www/current/public/;
    gzip_static on; # to serve pre-gzipped version
    expires max;
    add_header Cache-Control public;
  }

  location @backend {
    proxy_set_header X-Forwarded-Proto 'http';
    proxy_set_header Host $server_name;
    proxy_pass http://www;
  }
}
    """
