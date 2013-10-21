@quirkafleeg @apps @news
Feature: GDS apps
  In order to run Quirkafleeg
  I need to run the news frontend

  Background:
    * I ssh to "frontend-quirkafleeg-01" with the following credentials:
      | username | keyfile |
      | $lxc$    | $lxc$   |

  Scenario: news exists
    * directory "/var/www/news" should exist
    And directory "/var/www/news/shared" should exist
    And directory "/var/www/news/shared/log" should exist
    And directory "/var/www/news/shared/log" should be owned by "quirkafleeg:quirkafleeg"

  Scenario: Assets have been compiled
    * directory "/var/www/news/current/public/assets/" should exist

  Scenario: env is all good
    * file "/home/quirkafleeg/env" should exist
    And symlink "/var/www/news/current/.env" should exist
    When I run "cat /var/www/news/current/.env"
    Then I should see "RACKSPACE_USERNAME: rax" in the output
    And I should see "RACKSPACE_DIRECTORY_ASSET_HOST: http://3c1" in the output
    And I should see "JENKINS_URL: http://jenkins.theodi.org" in the output
    And I should see "GOVUK_ASSET_ROOT: static.quirkafleeg.info" in the output
    And I should see "DEV_DOMAIN: quirkafleeg.info" in the output
    And I should see "GOVUK_APP_DOMAIN: quirkafleeg.info" in the output
    And I should see "GDS_SSO_STRATEGY: real" in the output

  Scenario: startup scripts be all up in it
    * file "/etc/init/news.conf" should exist
    And file "/etc/init/news-thin.conf" should exist
    And file "/etc/init/news-thin-1.conf" should exist
    When I run "cat /etc/init/news-thin-1.conf"
    Then I should see "exec su - quirkafleeg -c 'cd /var/www/news/releases/" in the output
    And I should see "export PORT=3010" in the output
    And I should see "bundle exec thin start -p \$PORT >> /var/log/quirkafleeg/news/thin-1.log 2>&1" in the output

  Scenario: news vhost exists
    * file "/var/www/news/current/vhost" should exist

  Scenario: news vhost is correct
    And file "/var/www/news/current/vhost" should contain
    """
upstream news {
  server 127.0.0.1:3010;
}

server {
  listen 8080;
  server_name news.quirkafleeg.info;
  access_log /var/log/nginx/news.log;
  error_log /var/log/nginx/news.err;

  location / {
    try_files $uri @backend;
  }

  location ~ ^/(assets)/  {
    root /var/www/news/current/public/;
    gzip_static on; # to serve pre-gzipped version
    expires max;
    add_header Cache-Control public;
  }

  location @backend {
    proxy_set_header X-Forwarded-Proto 'http';
    proxy_set_header Host $server_name;
    proxy_pass http://news;
  }
}
    """
