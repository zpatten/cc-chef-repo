@odc @web
Feature: webserver
  In order to ODC
  I need some hot www action

  Background:
    * I ssh to "web-certificate-01" with the following credentials:
      | username | keyfile |
      | $lxc$    | $lxc$   |

  Scenario: Core dependencies are installed
    * package "build-essential" should be installed
    * package "git" should be installed
    * package "curl" should be installed

#  Scenario: User 'certificate' exists
#    * I run "su - certificate -c 'echo ${SHELL}'"
#    * I should see "/bin/bash" in the output
#
#  Scenario: User can sudo with no password
#  # we cannot test this properly on Vagrant!
#  #  * I run "su - certificate -c 'sudo bash'"
#  #  * I should not see "password for certificate" in the output
#  # So we compromise with this
#    * file "/etc/sudoers.d/certificate" should exist
#    * file "/etc/sudoers.d/certificate" should contain
#    """
#certificate ALL=NOPASSWD:ALL
#    """
#    * file "/etc/sudoers" should contain
#    """
##includedir /etc/sudoers.d
#    """
#    * I run "stat -c %a /etc/sudoers.d/certificate"
#    * I should see "440" in the output
#
#  Scenario: Ruby 1.9.3-p392 is installed
#    * I run "su - certificate -c 'ruby -v'"
#    * I should see "1.9.3p392" in the output
#
#  Scenario: Gem dependencies are installed
#    * package "libxml2-dev" should be installed
#    * package "libxslt1-dev" should be installed
#    * package "libcurl4-openssl-dev" should be installed
#    * package "libmysqlclient-dev" should be installed
#    When I run "node -h"
#    Then I should not see "command not found" in the output
#
#  Scenario: nginx is installed
#    * package "nginx" should be installed
#
#  Scenario: The env file exists
#    * file "/var/www/certificates.theodi.org/shared/config/env" should exist
#
#  Scenario: The env file contains the correct stuff
#    When I run "cat /var/www/certificates.theodi.org/shared/config/env"
#    Then I should see "JENKINS_URL: http://jenkins.theodi.org" in the output
#    And I should see "RESQUE_REDIS_HOST: 151" in the output
#    And I should see "EVENTBRITE_API_KEY: IZ" in the output
#    And I should see "CAPSULECRM_DEFAULT_OWNER: ri" in the output
#    And I should see "LEFTRONIC_GITHUB_OUTGOING_PRS: d" in the output
#    And I should see "COURSES_TARGET_URL: http:" in the output
#    And I should see "TRELLO_DEV_KEY: a1" in the output
#    And I should see "GITHUB_OUATH_TOKEN: 18" in the output
#    And I should see "GOOGLE_ANALYTICS_TRACKER: UA-3" in the output
#    And I should see "XERO_PRIVATE_KEY_PATH: /etc" in the output
#    And I should see "COURSES_RSYNC_PATH: json" in the output
#
#  @env
#  Scenario: environment-specific env file contains correct stuff
#    When I run "cat /var/www/certificates.theodi.org/current/.env.production"
#    Then I should see "MEMCACHED_HOSTS: 192.168.77.50" in the output
#    And file "/var/www/certificates.theodi.org/current/.env.production" should be owned by "certificate:certificate"
#
#  Scenario: Code is deployed
#    * directory "/var/www/certificates.theodi.org" should exist
#    * directory "/var/www/certificates.theodi.org/releases" should exist
#    * directory "/var/www/certificates.theodi.org/shared" should exist
#    * directory "/var/www/certificates.theodi.org/shared/config" should exist
#    * directory "/var/www/certificates.theodi.org/shared/pid" should exist
#    * directory "/var/www/certificates.theodi.org/shared/log" should exist
#    * directory "/var/www/certificates.theodi.org/shared/system" should exist
#
#  @config
#  Scenario: configuration stuff is correct
#    * file "/var/www/certificates.theodi.org/current/config/database.yml" should exist
#    * file "/var/www/certificates.theodi.org/current/config/database.yml" should be owned by "certificate:certificate"
#    * symlink "/var/www/certificates.theodi.org/current/.env" should exist
#    When I run "stat -c %N /var/www/certificates.theodi.org/current/.env"
#    Then I should see "../../shared/config/env" in the output
#    When I run "cat /var/www/certificates.theodi.org/current/config/database.yml"
#    Then I should see "production:" in the output
#    And I should see "adapter: mysql2" in the output
#    And I should see "port: 3306" in the output
#    And I should see "host: 192.168.77.51" in the output
#    And I should see "database: certificate" in the output
#    And I should see "username: certificate" in the output
#    And I should see "password: etacifitrec" in the output
#
#  Scenario: Assets have been compiled
#    * directory "/var/www/certificates.theodi.org/current/public/assets/" should exist
#
#  @startup
#  Scenario: Startup scripts are in play
#    * file "/etc/init/open-data-certificate.conf" should exist
#    * file "/etc/init/open-data-certificate-thin.conf" should exist
#    * file "/etc/init/open-data-certificate-thin-1.conf" should exist
#    When I run "cat /etc/init/open-data-certificate-thin-1.conf"
#    Then I should see "exec su - certificate" in the output
#    And I should see "export PORT=3000" in the output
#  #    And I should see "RACK_ENV=production" in the output
#    And I should see "/var/log/open-data-certificate/thin-1.log" in the output
#
#  @nginx
#  Scenario: nginx default vhost is disabled
#    * symlink "/etc/nginx/sites-enabled/default" should not exist
#
#  @nginx
#  Scenario: certificates on port 81 should be the ultimate destination
#    * file "/etc/nginx/sites-available/certificates.theodi.org.ssl" should contain
#    """
#upstream open-data-certificate {
#  server 127.0.0.1:3000;
#}
#
#server {
#  listen 81 default;
#  server_name certificates.theodi.org;
#  access_log /var/log/nginx/certificates.theodi.org.ssl.log;
#  error_log /var/log/nginx/certificates.theodi.org.ssl.err;
#  location / {
#    try_files $uri @backend;
#  }
#
#  location ~ ^/(assets)/  {
#    root /var/www/certificates.theodi.org/current/public/;
#    gzip_static on; # to serve pre-gzipped version
#    expires max;
#    add_header Cache-Control public;
#  }
#
#  location @backend {
#    proxy_set_header X-Forwarded-Proto 'http';
#    proxy_set_header Host $server_name;
#    proxy_pass http://open-data-certificate;
#  }
#}
#    """
#    * symlink "/etc/nginx/sites-enabled/certificates.theodi.org.ssl" should exist
#
#  @nginx @redirect
#  Scenario: certificates on port 80 should redirect
#    * file "/etc/nginx/sites-available/certificates.theodi.org" should contain
#    """
#server {
#  listen 80;
#  server_name certificates.theodi.org;
#  access_log /var/log/nginx/certificates.theodi.org.log;
#  error_log /var/log/nginx/certificates.theodi.org.err;
#  rewrite  ^/(.*)$ https://certificates.theodi.org/$1 permanent;
#}
#      """
#    * symlink "/etc/nginx/sites-enabled/certificates.theodi.org" should exist
#
#  @nginx @redirect @wip
#Scenario: certificate on port 80 should redirect
#  * file "/etc/nginx/sites-available/certificate.theodi.org" should contain
#  """
#server {
#  listen 80;
#  server_name certificate.theodi.org;
#  access_log /var/log/nginx/certificate.theodi.org.log;
#  error_log /var/log/nginx/certificate.theodi.org.err;
#  rewrite  ^/(.*)$ https://certificates.theodi.org/$1 permanent;
#}
#      """
#  * symlink "/etc/nginx/sites-enabled/certificate.theodi.org" should exist
#
#@nginx @redirect @wip
#Scenario: certificate on port 81 should redirect
#  * file "/etc/nginx/sites-available/certificate.theodi.org.ssl" should contain
#  """
#server {
#  listen 81;
#  server_name certificate.theodi.org;
#  access_log /var/log/nginx/certificate.theodi.org.ssl.log;
#  error_log /var/log/nginx/certificate.theodi.org.ssl.err;
#  rewrite  ^/(.*)$ https://certificates.theodi.org/$1 permanent;
#}
#      """
#  * symlink "/etc/nginx/sites-enabled/certificate.theodi.org.ssl" should exist
#
##  Scenario: nginx should be restarted
### we can't really test this
#
#  @chef-client
#  Scenario: chef-client is cronned
#    When I run "cat /etc/cron.d/chef-client"
#    Then I should see "/usr/bin/chef-client &> /var/log/chef/cron.log" in the output
#
#  @logstash
#  Scenario: logstash agent is correctly configured
#    * file "/opt/logstash/agent/etc/shipper.conf" should contain
#    """
#    input {
#      file {
#        type => "sample-logs"
#          path => [
#            "/var/log/*.log",
#            "/var/log/nginx/*",
#            "/var/log/open-data-certificate/thin-1.log",
#            "/var/www/certificates.theodi.org/shared/log/production.log",
#            "/var/log/chef/cron.log",
#            "/var/log/logstash/logstash.log"
#          ]
#          exclude => ["*.gz"]
#          debug => true
#      }
#    }
#
#
#    output {
#      tcp { host => "192.168.77.41" port => "5959" }
#    }
#    """