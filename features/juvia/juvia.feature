@juvia @web

Feature: Build a juvia node

  In order to facilitate lots of angry shouting
  On the internet
  I want to host a Juvia instance

  Background:
    * I ssh to "juvia" with the following credentials:
      | username | keyfile |
      | $lxc$    | $lxc$   |

  Scenario: Core dependencies are installed
    * package "build-essential" should be installed
    And package "git" should be installed
    And package "curl" should be installed

  Scenario: User 'juvia' exists
    When I run "su - juvia -c 'echo ${SHELL}'"
    Then I should see "/bin/bash" in the output

  Scenario: User can sudo with no password
  # we cannot test this properly on Vagrant!
  #  * I run "su - juvia -c 'sudo bash'"
  #  * I should not see "password for juvia" in the output
  # So we compromise with this
    * file "/etc/sudoers.d/juvia" should exist
    And file "/etc/sudoers.d/juvia" should contain
    """
juvia ALL=NOPASSWD:ALL
    """
    And file "/etc/sudoers" should contain
    """
#includedir /etc/sudoers.d
    """
    When I run "stat -c %a /etc/sudoers.d/juvia"
    Then I should see "440" in the output

  Scenario: Ruby 1.9.3 is installed
    When I run "su - juvia -c 'ruby -v'"
    Then I should see "1.9.3" in the output

  Scenario: code is deployed
    * directory "/var/www/juvia.theodi.org" should exist
    And directory "/var/www/juvia.theodi.org/shared" should exist
    And directory "/var/www/juvia.theodi.org/shared/log" should exist
    And directory "/var/www/juvia.theodi.org/shared/log" should be owned by "juvia:juvia"

  Scenario: Assets have been compiled
    * directory "/var/www/juvia.theodi.org/current/public/assets/" should exist

  Scenario: Startup scripts are in play
    * file "/etc/init/juvia.conf" should exist
    And file "/etc/init/juvia-thin.conf" should exist
    And file "/etc/init/juvia-thin-1.conf" should exist
    When I run "cat /etc/init/juvia-thin-1.conf"
    Then I should see "exec su - juvia" in the output
    And I should see "export PORT=3000" in the output
    And I should see "RACK_ENV=production" in the output
    And I should see "/var/log/juvia/thin-1.log" in the output

  Scenario: The env file exists
    * file "/home/juvia/env" should exist

  Scenario: The env file contains the correct stuff
    When I run "cat /var/www/juvia.theodi.org/current/.env"
    Then I should see "JENKINS_URL: http://jenkins.theodi.org" in the output
    And I should see "EVENTBRITE_API_KEY: IZ" in the output
    And I should see "CAPSULECRM_DEFAULT_OWNER: ri" in the output
    And I should see "LEFTRONIC_GITHUB_OUTGOING_PRS: d" in the output
    And I should see "COURSES_TARGET_URL: http:" in the output
    And I should see "TRELLO_DEV_KEY: a1" in the output
    And I should see "GITHUB_OUATH_TOKEN: 18" in the output
    And I should see "GOOGLE_ANALYTICS_TRACKER: UA-3" in the output
    And I should see "XERO_PRIVATE_KEY_PATH: /etc" in the output
    And I should see "COURSES_RSYNC_PATH: json" in the output
    And I should see "JUVIA_BASE_URL: http://juvia.theodi.org" in the output
    And I should see "JUVIA_EMAIL_FROM: juvia@theodi.org" in the output
    And I should see "RACK_ENV: production" in the output

  Scenario: configuration stuff is correct
    * symlink "/var/www/juvia.theodi.org/current/config/database.yml" should exist
    And file "/var/www/juvia.theodi.org/current/database.yml" should be owned by "juvia:juvia"
    When I run "cat /var/www/juvia.theodi.org/current/config/database.yml"
    Then I should see "production:" in the output
    And I should see "adapter: mysql2" in the output
    And I should see "port: 3306" in the output
    And I should see "host: 192.168.96.10" in the output
    And I should see "database: juvia" in the output
    And I should see "username: juvia" in the output
    And I should see "password: thisisnotarealpassword" in the output

  Scenario: nginx is kosher
    * package "nginx" should be installed
    And symlink "/etc/nginx/sites-enabled/default" should not exist

  Scenario: vhost is correct
    * file "/var/www/juvia.theodi.org/current/vhost" should contain
    """
upstream juvia {
  server 127.0.0.1:3000;
}

server {
  listen 80;
  server_name juvia.theodi.org;
  access_log /var/log/nginx/juvia.theodi.org.log;
  error_log /var/log/nginx/juvia.theodi.org.err;

  location / {
    try_files $uri @backend;
  }

  location ~ ^/(assets)/  {
    root /var/www/juvia.theodi.org/current/public/;
    gzip_static on; # to serve pre-gzipped version
    expires max;
    add_header Cache-Control public;
  }

  location @backend {
    proxy_set_header X-Forwarded-Proto 'http';
    proxy_set_header Host $server_name;
    proxy_pass http://juvia;
  }
}
    """
    And symlink "/etc/nginx/sites-enabled/juvia.theodi.org" should exist

  @chef-client
  Scenario: chef-client should be cronned
    When I run "cat /etc/cron.d/chef-client"
    Then I should see "^\*/5 .* /usr/bin/chef-client &> /var/log/chef/cron.log" in the output
    When I run "ps ax"
    Then I should not see "chef-client .* -i .* -s" in the output