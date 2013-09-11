@quirkafleeg @apps @courses
Feature: GDS apps
  In order to run Quirkafleeg
  I need to run the courses frontend

  Background:
    * I ssh to "frontend-quirkafleeg-01" with the following credentials:
      | username | keyfile |
      | $lxc$    | $lxc$   |

  Scenario: courses exists
    * directory "/var/www/courses" should exist
    And directory "/var/www/courses/shared" should exist
    And directory "/var/www/courses/shared/log" should exist
    And directory "/var/www/courses/shared/log" should be owned by "quirkafleeg:quirkafleeg"

  Scenario: Assets have been compiled
    * directory "/var/www/courses/current/public/assets/" should exist

  Scenario: env is all good
    * file "/home/quirkafleeg/env" should exist
    And symlink "/var/www/courses/current/.env" should exist
    When I run "cat /var/www/courses/current/.env"
    Then I should see "RACKSPACE_USERNAME: rax" in the output
    And I should see "RACKSPACE_DIRECTORY_ASSET_HOST: http://3c1" in the output
    And I should see "JENKINS_URL: http://jenkins.theodi.org" in the output
    And I should see "GOVUK_ASSET_ROOT: static.quirkafleeg.info" in the output
    And I should see "DEV_DOMAIN: quirkafleeg.info" in the output
    And I should see "GOVUK_APP_DOMAIN: quirkafleeg.info" in the output
    And I should see "GDS_SSO_STRATEGY: real" in the output

  Scenario: startup scripts be all up in it
    * file "/etc/init/courses.conf" should exist
    And file "/etc/init/courses-thin.conf" should exist
    And file "/etc/init/courses-thin-1.conf" should exist
    When I run "cat /etc/init/courses-thin-1.conf"
    Then I should see "exec su - quirkafleeg -c 'cd /var/www/courses/releases/" in the output
    And I should see "export PORT=3030" in the output
    And I should see "bundle exec thin start -p \$PORT >> /var/log/quirkafleeg/courses/thin-1.log 2>&1" in the output

  Scenario: courses vhost exists
    * file "/var/www/courses/current/vhost" should exist

  Scenario: courses vhost is correct
    And file "/var/www/courses/current/vhost" should contain
    """
upstream courses {
  server 127.0.0.1:3030;
}

server {
  listen 8080;
  server_name courses.quirkafleeg.info;
  access_log /var/log/nginx/courses.log;
  error_log /var/log/nginx/courses.err;

  location / {
    try_files $uri @backend;
  }

  location ~ ^/(assets)/  {
    root /var/www/courses/current/public/;
    gzip_static on; # to serve pre-gzipped version
    expires max;
    add_header Cache-Control public;
  }

  location @backend {
    proxy_set_header X-Forwarded-Proto 'http';
    proxy_set_header Host $server_name;
    proxy_pass http://courses;
  }
}
    """
