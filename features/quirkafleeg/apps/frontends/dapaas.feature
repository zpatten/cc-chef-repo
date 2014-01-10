@quirkafleeg @apps @dapaas
Feature: GDS apps
  In order to DaPaaS
  I need to run the dapaas frontend

  Background:
    * I ssh to "dapaas-quirkafleeg-01" with the following credentials:
      | username | keyfile |
      | $lxc$    | $lxc$   |

  Scenario: www exists
    * directory "/var/www/dapaas" should exist
    And directory "/var/www/dapaas/shared" should exist
    And directory "/var/www/dapaas/shared/log" should exist
    And directory "/var/www/dapaas/shared/log" should be owned by "quirkafleeg:quirkafleeg"

  Scenario: env is all good
    * file "/home/quirkafleeg/env" should exist
    And symlink "/var/www/dapaas/current/.env" should exist
    When I run "cat /var/www/dapaas/current/.env"
    Then I should see "RACKSPACE_USERNAME: rax" in the output
    And I should see "RACKSPACE_DIRECTORY_ASSET_HOST: http://3c1" in the output
    And I should see "JENKINS_URL: http://jenkins.theodi.org" in the output
    And I should see "GOVUK_ASSET_ROOT: static.theodi.org" in the output
    And I should see "DEV_DOMAIN: theodi.org" in the output
    And I should see "GOVUK_APP_DOMAIN: theodi.org" in the output
    And I should see "GDS_SSO_STRATEGY: real" in the output
    And I should see "GOVUK_WEBSITE_ROOT: theodi.org" in the output

  Scenario: startup scripts be all up in it
    * file "/etc/init/dapaas.conf" should exist
    And file "/etc/init/dapaas-thin.conf" should exist
    And file "/etc/init/dapaas-thin-1.conf" should exist
    When I run "cat /etc/init/dapaas-thin-1.conf"
    Then I should see "exec su - quirkafleeg -c 'cd /var/www/dapaas/releases/" in the output
    And I should see "export PORT=3056" in the output
    And I should see "bundle exec thin start -p \$PORT >> /var/log/quirkafleeg/dapaas/thin-1.log 2>&1" in the output

  Scenario: dapaas vhost exists
    * file "/var/www/dapaas/current/vhost" should exist

  Scenario: dapaas vhost is correct
    * file "/var/www/dapaas/current/vhost" should contain
  """
upstream dapaas {
  server 127.0.0.1:3056;
}

server {
  listen 8080 default;
  server_name project.dapaas.eu;
  access_log /var/log/nginx/dapaas.log;
  error_log /var/log/nginx/dapaas.err;
  root /var/www/dapaas/current/public/;

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
    proxy_pass http://dapaas;
  }
}
  """

  Scenario: vhost redirects are correct
    And file "/var/www/dapaas/current/vhost" should contain
  """
server {
  listen 8080;
  server_name dapaas.eu;
  rewrite ^/(.*) http://project.dapaas.eu/$1 permanent;
}
  """
