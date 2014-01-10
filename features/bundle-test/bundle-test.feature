@bundletest

Feature: Get bundle bundling

  Bundler is borked

  Background:
    * I ssh to "bundle-test" with the following credentials:
      | username | keyfile |
      | $lxc$    | $lxc$   |

  Scenario: User 'bundletest' exists
    When I run "su - bundletest -c 'echo ${SHELL}'"
    Then I should see "/bin/bash" in the output

  Scenario: User can sudo with no password
  # we cannot test this properly on Vagrant!
  #  * I run "su - metrics -c 'sudo bash'"
  #  * I should not see "password for metrics" in the output
  # So we compromise with this
    * file "/etc/sudoers.d/bundletest" should exist
    And file "/etc/sudoers.d/bundletest" should contain
    """
bundletest ALL=NOPASSWD:ALL
    """
    And file "/etc/sudoers" should contain
    """
#includedir /etc/sudoers.d
    """
    When I run "stat -c %a /etc/sudoers.d/bundletest"
    Then I should see "440" in the output

  Scenario: Ruby 2.1.0 is installed
    When I run "su - bundletest -c 'ruby -v'"
    Then I should see "2.1.0" in the output

  Scenario: Code is deployed
    * directory "/var/www/csvlint.io" should exist
    And directory "/var/www/csvlint.io/releases" should exist
    And directory "/var/www/csvlint.io/shared" should exist
    And directory "/var/www/csvlint.io/shared/config" should exist
    And directory "/var/www/csvlint.io/shared/log" should exist

  Scenario: Bundling has occurred
    * directory "/var/www/csvlint.io/shared/bundle/ruby/2.1.0/gems" should exist

  Scenario: Startup scripts exist
    When I run "cat /etc/init/csvlint-thin-1.conf"
    Then I should see "exec su - bundletest" in the output
    And I should see "export PORT=3000; RACK_ENV=production bundle exec thin start" in the output

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