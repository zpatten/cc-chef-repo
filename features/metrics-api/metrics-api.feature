@metrics-api @api
Feature: api role
  In order to run some metrics thing
  I want a mongodb server

  Background:
    * I ssh to "metrics-api" with the following credentials:
      | username | keyfile |
      | $lxc$    | $lxc$   |

  Scenario: Core dependencies are installed
    * package "build-essential" should be installed
    And package "git" should be installed
    And package "curl" should be installed

  Scenario: User 'metrics' exists
    When I run "su - metrics -c 'echo ${SHELL}'"
    Then I should see "/bin/bash" in the output

  Scenario: User can sudo with no password
  # we cannot test this properly on Vagrant!
  #  * I run "su - metrics -c 'sudo bash'"
  #  * I should not see "password for metrics" in the output
  # So we compromise with this
    * file "/etc/sudoers.d/metrics" should exist
    And file "/etc/sudoers.d/metrics" should contain
    """
metrics ALL=NOPASSWD:ALL
    """
    And file "/etc/sudoers" should contain
    """
#includedir /etc/sudoers.d
    """
    When I run "stat -c %a /etc/sudoers.d/metrics"
    Then I should see "440" in the output

  Scenario: Ruby 2.0.0 is installed
    When I run "su - metrics -c 'ruby -v'"
    Then I should see "2.0.0" in the output

  Scenario: Code is deployed
    * directory "/var/www/metrics.theodi.org" should exist
    And directory "/var/www/metrics.theodi.org/releases" should exist
    And directory "/var/www/metrics.theodi.org/shared" should exist
    And directory "/var/www/metrics.theodi.org/shared/config" should exist
    And directory "/var/www/metrics.theodi.org/shared/log" should exist
    And symlink "/var/www/metrics.theodi.org/current/.env" should exist

  @startup
  Scenario: Startup scripts are in play
    * file "/etc/init/metrics-api.conf" should exist
    And file "/etc/init/metrics-api-web.conf" should exist
    And file "/etc/init/metrics-api-web-1.conf" should exist
    When I run "cat /etc/init/metrics-api-web-1.conf"
    Then I should see "exec su - metrics" in the output
    And I should see "export PORT=3000" in the output
    And I should see "/var/log/metrics-api/web-1.log" in the output

  @nginx
  Scenario: nginx virtualhosts are correct
    * symlink "/etc/nginx/sites-enabled/default" should not exist
    And file "/var/www/metrics.theodi.org/current/vhost" should exist

  @nginx @vhost
  Scenario: virtualhost should contain correct stuff
    * file "/var/www/metrics.theodi.org/current/vhost" should contain
    """
upstream metrics-api {
  server 127.0.0.1:3000;
}

server {
  listen 80 default;
  server_name metrics.theodi.org;
  access_log /var/log/nginx/metrics.theodi.org.log;
  error_log /var/log/nginx/metrics.theodi.org.err;
  location / {
    try_files $uri @backend;
  }

  location ~ ^/(assets)/ {
    root /var/www/metrics.theodi.org/current/public/;
    gzip_static on; # to serve pre-gzipped version
    expires max;
    add_header Cache-Control public;
  }

  location @backend {
    proxy_set_header X-Forwarded-Proto 'http';
    proxy_set_header Host $server_name;
    proxy_pass http://metrics-api;
  }
}
    """

  Scenario: virtualhost should be symlinked
    * symlink "/etc/nginx/sites-enabled/metrics.theodi.org" should exist

#  Scenario: nginx should be restarted
## we can't really test this