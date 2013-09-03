@quirkafleeg @apps
Feature: GDS apps
  In order to run Quirkafleeg
  I need some apps

  Background:
    * I ssh to "web-quirkafleeg-01" with the following credentials:
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
    And I should see "GOVUK_ASSET_ROOT: static.192.168.99.30.xip.io" in the output
    And I should see "DEV_DOMAIN: 192.168.99.30.xip.io" in the output
    And I should see "GOVUK_APP_DOMAIN: 192.168.99.30.xip.io" in the output
    And I should see "GDS_SSO_STRATEGY: real" in the output

  Scenario: startup scripts be all up in it
    * file "/etc/init/signon.conf" should exist
    And file "/etc/init/signon-thin.conf" should exist
    And file "/etc/init/signon-thin-1.conf" should exist
    When I run "cat /etc/init/signon-thin-1.conf"
    Then I should see "exec su - quirkafleeg -c 'cd /var/www/signon/releases/" in the output
    And I should see "export PORT=3000" in the output
    And I should see "bundle exec thin start -p \$PORT >> /var/log/quirkafleeg/signon/thin-1.log 2>&1" in the output

  @fail
  Scenario: signon vhost exists
    * file "/var/www/signon/current/vhost" should exist

  Scenario: signon vhost is correct
    And file "/var/www/signon/current/vhost" should contain
    """
upstream signon {
  server 127.0.0.1:3000;
}

server {
  listen 80;
  server_name signon.192.168.99.30.xip.io;
  access_log /var/log/nginx/signon.log;
  error_log /var/log/nginx/signon.err;

  location / {
    try_files $uri @backend;
  }

  location ~ ^/(assets)/  {
    root /var/www/signon/current/public/;
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

  Scenario: signon vhost is symlinked
    And symlink "/etc/nginx/sites-enabled/signon" should exist

  Scenario: static vhost exist
    * file "/var/www/static/current/vhost" should exist

  Scenario: static vhost is correct
    And file "/var/www/static/current/vhost" should contain
    """
upstream static {
  server 127.0.0.1:4000;
}
    """

  Scenario: panopticon vhost exists
    And file "/var/www/panopticon/current/vhost" should exist

  Scenario: panopticon vhost is correct
    And file "/var/www/panopticon/current/vhost" should contain
    """
upstream panopticon {
  server 127.0.0.1:5000;
}
    """

  @failboat
  Scenario: publisher vhost exists
    And file "/var/www/publisher/current/vhost" should exist

  @failboat
  Scenario: publisher vhost is correct
    And file "/var/www/publisher/current/vhost" should contain
    """
upstream publisher {
  server 127.0.0.1:6000;
}
    """

  @mongo  @failboat
  Scenario: mongoid conf file is correct
    * file "/var/www/publisher/shared/config/mongoid.yml" should exist
    And file "/var/www/publisher/shared/config/mongoid.yml" should contain
    """
production:
  host: 192.168.99.10
  port: 27017
  username:
  password:
  database: govuk_content_publisher
  use_activesupport_time_zone: true
    """
    And symlink "/var/www/publisher/current/config/mongoid.yml" should exist
    And symlink "/var/www/publisher/current/mongoid.yml" should exist

  @mysql
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

  @failboat
  Scenario: contentapi vhost is correct
    * file "/etc/nginx/sites-enabled/contentapi" should contain
    """
    upstream contentapi {
  server 127.0.0.1:7000;
}

server {
  listen 80;
  server_name contentapi.192.168.99.30.xip.io;
  access_log /var/log/nginx/contentapi.log;
  error_log /var/log/nginx/contentapi.err;

  location / {
    try_files $uri @backend;
  }

  location @backend {
    proxy_set_header X-Forwarded-Proto 'http';
    proxy_set_header Host $server_name;
    proxy_pass http://contentapi;
  }
}
    """