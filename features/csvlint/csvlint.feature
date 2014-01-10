@csvlint
Feature: Make me a csvlint node

  CSVs are generally TERRIBLE

  Background:
    * I ssh to "csvlint-01" with the following credentials:
      | username | keyfile |
      | $lxc$    | $lxc$   |

  Scenario: The Chef-Server validation key has been removed
    When I run "[[ ! -e /etc/chef/validation.pem ]]"
    Then the exit code should be "0"

  Scenario: chef-client should be cronned
    When I run "cat /etc/cron.d/chef-client"
    Then I should see "^\*/5 .* /usr/bin/chef-client &> /var/log/chef/cron.log" in the output
    When I run "ps ax"
    Then I should not see "chef-client .* -i .* -s" in the output

  Scenario: User 'csvlint' exists
    When I run "su - csvlint -c 'echo ${SHELL}'"
    Then I should see "/bin/bash" in the output

  Scenario: User can sudo with no password
  # we cannot test this properly on Vagrant!
  #  * I run "su - metrics -c 'sudo bash'"
  #  * I should not see "password for metrics" in the output
  # So we compromise with this
    * file "/etc/sudoers.d/csvlint" should exist
    And file "/etc/sudoers.d/csvlint" should contain
    """
csvlint ALL=NOPASSWD:ALL
    """
    And file "/etc/sudoers" should contain
    """
#includedir /etc/sudoers.d
    """
    When I run "stat -c %a /etc/sudoers.d/csvlint"
    Then I should see "440" in the output

  Scenario: Ruby 2.1.0 is installed
    When I run "su - csvlint -c 'ruby -v'"
    Then I should see "2.1.0" in the output

  Scenario: Code is deployed
    * directory "/var/www/csvlint.io" should exist
    And directory "/var/www/csvlint.io/releases" should exist
    And directory "/var/www/csvlint.io/shared" should exist
    And directory "/var/www/csvlint.io/shared/config" should exist
    And directory "/var/www/csvlint.io/shared/log" should exist

  Scenario: Bundling has occurred
    * directory "/var/www/csvlint.io/shared/bundle/ruby/2.1.0/gems" should exist

  Scenario: Assets have been compiled
    * directory "/var/www/csvlint.io/current/public/assets/" should exist

  Scenario: The env file exists
    * file "/home/csvlint/env" should exist

  Scenario: The env file contains the correct stuff
    When I run "cat /var/www/csvlint.io/current/.env"
    Then I should see "JENKINS_URL: http://jenkins.theodi.org" in the output
    And I should see "EVENTBRITE_API_KEY: IZ" in the output
    And I should see "CAPSULECRM_DEFAULT_OWNER: ri" in the output
    And I should see "TRELLO_DEV_KEY: a1" in the output
    And I should see "GITHUB_OUATH_TOKEN: 18" in the output
    And I should see "GOOGLE_ANALYTICS_TRACKER: UA-3" in the output
    And I should see "RACK_ENV: production" in the output

  Scenario: DB configuration is correct
    * symlink "/var/www/csvlint.io/current/config/database.yml" should exist
    When I run "stat -c %N /var/www/csvlint.io/current/config/database.yml"
    Then I should see "/var/www/csvlint.io/shared/config/database.yml" in the output
    And file "/var/www/csvlint.io/shared/config/database.yml" should be owned by "csvlint:csvlint"
    When I run "cat /var/www/csvlint.io/current/config/database.yml"
    Then I should see "production:" in the output
    And I should see "adapter: mysql2" in the output
    And I should see "port: 3306" in the output
    And I should see "host: 192.168.94.10" in the output
    And I should see "database: csvlint" in the output
    And I should see "username: csvlint" in the output

  Scenario: Startup scripts exist
    When I run "cat /etc/init/csvlint-thin-1.conf"
    Then I should see "exec su - csvlint" in the output
    And I should see "export PORT=3000" in the output
    And I should see "RACK_ENV=production bundle exec thin start" in the output

  Scenario: vhost is correct
    * file "/var/www/csvlint.io/current/vhost" should contain
    """
upstream csvlint {
  server 127.0.0.1:3000;
}

server {
  listen 80 default;
  server_name csvlint.io;
  access_log /var/log/nginx/csvlint.io.log;
  error_log /var/log/nginx/csvlint.io.err;
  root /var/www/csvlint.io/current/public/;

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
    proxy_pass http://csvlint;
  }
}
    """
    And file "/var/www/csvlint.io/current/vhost" should contain
    """
server {
  listen 80;
  server_name www.csvlint.io;
  rewrite ^/(.*) http://csvlint.io/$1 permanent;
}
    """
    And symlink "/etc/nginx/sites-enabled/csvlint.io" should exist
