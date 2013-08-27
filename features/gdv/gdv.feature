@git-data-viewer
Feature: Build a fully-operational battlestation^W git-viewer.labs.theodi.org node from scratch

  In order to run the git data viewer app
  As the ODI
  I want to install and configure many things

  Background:
    * I ssh to "git-data-viewer" with the following credentials:
      | username | keyfile |
      | $lxc$    | $lxc$   |

  Scenario: Core dependencies are installed
    * package "build-essential" should be installed
    * package "git" should be installed
    * package "curl" should be installed

#  Scenario: User 'git-data-viewer' exists
#    * I run "su - git-data-viewer -c 'echo ${SHELL}'"
#    * I should see "/bin/bash" in the output
#
#  Scenario: User can sudo with no password
#  # we cannot test this properly on Vagrant!
#  #  * I run "su - git-data-viewer -c 'sudo bash'"
#  #  * I should not see "password for git-data-viewer" in the output
#  # So we compromise with this
#    * file "/etc/sudoers.d/git-data-viewer" should exist
#    * file "/etc/sudoers.d/git-data-viewer" should contain
#    """
#git-data-viewer ALL=NOPASSWD:ALL
#    """
#    * file "/etc/sudoers" should contain
#    """
##includedir /etc/sudoers.d
#    """
#    * I run "stat -c %a /etc/sudoers.d/git-data-viewer"
#    * I should see "440" in the output
#
#  Scenario: Ruby 2.0.0-p0 is installed
#    * I run "su - git-data-viewer -c 'ruby -v'"
#    * I should see "2.0.0p0" in the output
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
#  @envfile
#  Scenario: The env file exists
#    * file "/var/www/git-viewer.labs.theodi.org/shared/config/env" should exist
#
#  Scenario: The env file contains the correct stuff
#    When I run "cat /var/www/git-viewer.labs.theodi.org/shared/config/env"
#    Then I should see "GITHUB_OAUTH_TOKEN: " in the output
#
#  Scenario: Code is deployed
#    * directory "/var/www/git-viewer.labs.theodi.org" should exist
#    * directory "/var/www/git-viewer.labs.theodi.org/releases" should exist
#    * directory "/var/www/git-viewer.labs.theodi.org/shared" should exist
#    * directory "/var/www/git-viewer.labs.theodi.org/shared/config" should exist
#    * directory "/var/www/git-viewer.labs.theodi.org/shared/pid" should exist
#    * directory "/var/www/git-viewer.labs.theodi.org/shared/log" should exist
#    * directory "/var/www/git-viewer.labs.theodi.org/shared/system" should exist
#
#  @configurationstuff
#  Scenario: configuration stuff is correct
#    * file "/var/www/git-viewer.labs.theodi.org/current/config/database.yml" should exist
#    * file "/var/www/git-viewer.labs.theodi.org/current/config/database.yml" should be owned by "git-data-viewer:git-data-viewer"
#    * symlink "/var/www/git-viewer.labs.theodi.org/current/.env" should exist
#    When I run "stat -c %N /var/www/git-viewer.labs.theodi.org/current/.env"
#    Then I should see "../../shared/config/env" in the output
#    When I run "cat /var/www/git-viewer.labs.theodi.org/current/config/database.yml"
#    Then I should see "production:" in the output
#    And I should see "adapter: mysql2" in the output
#    And I should see "port: 3306" in the output
#
#  Scenario: Assets have been compiled
#    * directory "/var/www/git-viewer.labs.theodi.org/current/public/assets/" should exist
#
#  @startup
#  Scenario: Startup scripts are in play
#    * file "/etc/init/git-data-viewer.conf" should exist
#    * file "/etc/init/git-data-viewer-thin.conf" should exist
#    * file "/etc/init/git-data-viewer-thin-1.conf" should exist
#    When I run "cat /etc/init/git-data-viewer-thin-1.conf"
#    Then I should see "exec su - git-data-viewer" in the output
#    And I should see "export PORT=3000" in the output
#  #    And I should see "RACK_ENV=production" in the output
#    And I should see "/var/log/git-data-viewer/thin-1.log" in the output
#
#  @nginx
#  Scenario: nginx virtualhosts are correct
#    * symlink "/etc/nginx/sites-enabled/default" should not exist
#    * file "/etc/nginx/sites-available/git-viewer.labs.theodi.org" should exist
#
#  @nginx @vhost
#  Scenario: virtualhost should contain correct stuff
#    * file "/etc/nginx/sites-available/git-viewer.labs.theodi.org" should contain
#    """
#upstream git-data-viewer {
#  server 127.0.0.1:3000;
#}
#
#server {
#  listen 80 default;
#  server_name git-viewer.labs.theodi.org;
#  access_log /var/log/nginx/git-viewer.labs.theodi.org.log;
#  error_log /var/log/nginx/git-viewer.labs.theodi.org.err;
#  location / {
#    try_files $uri @backend;
#  }
#
#  location ~ ^/(assets)/  {
#    root /var/www/git-viewer.labs.theodi.org/current/public/;
#    gzip_static on; # to serve pre-gzipped version
#    expires max;
#    add_header Cache-Control public;
#  }
#
#  location @backend {
#    proxy_set_header X-Forwarded-Proto 'http';
#    proxy_set_header Host $server_name;
#    proxy_pass http://git-data-viewer;
#  }
#}
#    """
#
#  Scenario: virtualhost should be symlinked
#    * symlink "/etc/nginx/sites-enabled/git-viewer.labs.theodi.org" should exist
#
#  Scenario: nginx should be restarted
## we can't really test this
#