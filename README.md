# OVERVIEW

This is an example `chef-repo` meant to illustrate the usage of cucumber-chef.  ENJOY!

# USING

**1)** I define these bash aliases for use with my ruby-related development:

    alias be='bundle exec'
    alias bi='bundle install'
    alias bibs='bundle install --binstubs'
    alias bu='bundle update'
    alias cbdev='export CBDEV=1'         # turn chef cookbook development on
    alias nocbdev='export CBDEV=0'       # turn chef cookbook development off
    alias gemdev='export GEMDEV=1'       # turn gem development on
    alias nogemdev='export GEMDEV=0'     # turn gem development off
    alias verbose='export VERBOSE=1'     # turn verbose on
    alias noverbose='export VERBOSE=0'   # turn verbose off
    alias rgs='rvm --force gemset empty' # reset-gemset

**2)** Clone this repo:

    [~] $ mkdir -p ~/code/
    [~] $ cd ~/code/
    [~/code] $ git clone git@github.com:zpatten/cc-chef-repo.git

**3)** Change to the repo directory and make sure the ruby and gemset specified in `.ruby-version` and `.ruby-gemset` are active.  Optionally set VERBOSE=1.

    [~/code] $ cd cc-chef-repo
    [~/code/cc-chef-repo] $ export VERBOSE=1

**4)** Clear your gemset, bundle update, bundle install binstubs:

    [~/code/cc-chef-repo] $ rgs && bu && bibs
    NOGEMDEV:                              ztk
    NOGEMDEV:                    cucumber-chef
    Fetching gem metadata from https://rubygems.org/.........
    Fetching gem metadata from https://rubygems.org/..
    Resolving dependencies...
    Using rake (10.0.4)
    Installing i18n (0.6.1)
    Installing multi_json (1.7.2)
    Installing activesupport (3.2.13)
    Installing archive-tar-minitar (0.5.2)
    Installing builder (3.2.0)
    Installing bunny (0.7.9)
    Installing erubis (2.7.0)
    Installing highline (1.6.17)
    Installing json (1.7.7)
    Installing mixlib-log (1.6.0)
    Installing mixlib-authentication (1.3.0)
    Installing mixlib-cli (1.3.0)
    Installing mixlib-config (1.1.2)
    Installing mixlib-shellout (1.1.0)
    Installing moneta (0.6.0)
    Installing net-ssh (2.6.7)
    Installing net-ssh-gateway (1.2.0)
    Installing net-ssh-multi (1.1)
    Installing ipaddress (0.8.0)
    Installing systemu (2.5.2)
    Installing yajl-ruby (1.1.0)
    Installing ohai (6.16.0)
    Installing mime-types (1.22)
    Installing rest-client (1.6.7)
    Installing polyglot (0.3.3)
    Installing treetop (1.4.12)
    Installing uuidtools (2.1.3)
    Installing chef (10.24.0)
    Installing diff-lcs (1.2.3)
    Installing gherkin (2.11.8)
    Installing cucumber (1.2.5)
    Installing excon (0.20.1)
    Installing formatador (0.2.4)
    Installing net-scp (1.1.0)
    Installing nokogiri (1.5.9)
    Installing ruby-hmac (0.4.0)
    Installing fog (1.10.1)
    Installing rspec-core (2.13.1)
    Installing rspec-expectations (2.13.0)
    Installing rspec-mocks (2.13.1)
    Installing rspec (2.13.0)
    Installing thor (0.18.1)
    Installing ubuntu_ami (0.4.1)
    Installing net-sftp (2.1.1)
    Installing ztk (1.0.11)
    Installing cucumber-chef (3.0.8)
    Installing librarian (0.1.0)
    Installing librarian-chef (0.0.1)
    Using bundler (1.3.5)
    Your bundle is updated!
    NOGEMDEV:                              ztk
    NOGEMDEV:                    cucumber-chef
    NOGEMDEV:                              ztk
    NOGEMDEV:                    cucumber-chef
    Using rake (10.0.4)
    Using i18n (0.6.1)
    Using multi_json (1.7.2)
    Using activesupport (3.2.13)
    Using archive-tar-minitar (0.5.2)
    Using builder (3.2.0)
    Using bunny (0.7.9)
    Using erubis (2.7.0)
    Using highline (1.6.17)
    Using json (1.7.7)
    Using mixlib-log (1.6.0)
    Using mixlib-authentication (1.3.0)
    Using mixlib-cli (1.3.0)
    Using mixlib-config (1.1.2)
    Using mixlib-shellout (1.1.0)
    Using moneta (0.6.0)
    Using net-ssh (2.6.7)
    Using net-ssh-gateway (1.2.0)
    Using net-ssh-multi (1.1)
    Using ipaddress (0.8.0)
    Using systemu (2.5.2)
    Using yajl-ruby (1.1.0)
    Using ohai (6.16.0)
    Using mime-types (1.22)
    Using rest-client (1.6.7)
    Using polyglot (0.3.3)
    Using treetop (1.4.12)
    Using uuidtools (2.1.3)
    Using chef (10.24.0)
    Using diff-lcs (1.2.3)
    Using gherkin (2.11.8)
    Using cucumber (1.2.5)
    Using excon (0.20.1)
    Using formatador (0.2.4)
    Using net-scp (1.1.0)
    Using nokogiri (1.5.9)
    Using ruby-hmac (0.4.0)
    Using fog (1.10.1)
    Using rspec-core (2.13.1)
    Using rspec-expectations (2.13.0)
    Using rspec-mocks (2.13.1)
    Using rspec (2.13.0)
    Using thor (0.18.1)
    Using ubuntu_ami (0.4.1)
    Using net-sftp (2.1.1)
    Using ztk (1.0.11)
    Using cucumber-chef (3.0.8)
    Using librarian (0.1.0)
    Using librarian-chef (0.0.1)
    Using bundler (1.3.5)
    Your bundle is complete!
    Use `bundle show [gemname]` to see where a bundled gem is installed.
    [~/code/cc-chef-repo] $

**5)** Update the librarian-chef bundle:

    [~/code/cc-chef-repo] $ bin/librarian-chef update
    NOGEMDEV:                              ztk
    NOGEMDEV:                    cucumber-chef
     NOCBDEV:                            users, {:git=>"git@github.com:zpatten/chef-cookbook-users.git"}
     NOCBDEV:                             sudo, {:git=>"git@github.com:zpatten/chef-cookbook-sudo.git"}
     NOCBDEV:                            users, {:git=>"git@github.com:zpatten/chef-cookbook-users.git"}
     NOCBDEV:                             sudo, {:git=>"git@github.com:zpatten/chef-cookbook-sudo.git"}
    Installing apache2 (1.6.0)
    Installing apt (1.9.2)
    Installing rsyslog (1.5.0)
    Installing bluepill (2.2.2)
    Installing build-essential (1.3.4)
    Installing cron (1.2.2)
    Installing chef-client (2.2.2)
    Installing yum (2.2.0)
    Installing erlang (1.2.0)
    Installing couchdb (2.4.0)
    Installing ucspi-tcp (1.0.0)
    Installing daemontools (1.0.0)
    Installing gecode (2.0.0)
    Installing chef_handler (1.1.4)
    Installing windows (1.8.8)
    Installing java (1.10.0)
    Installing ohai (1.1.8)
    Installing nginx (1.4.0)
    Installing openssl (1.0.2)
    Installing runit (1.1.2)
    Installing xml (1.1.2)
    Installing zlib (2.0.0)
    Installing chef-server (1.1.0)
    Installing dmg (1.1.0)
    Installing git (2.4.0)
    Installing motd-tail (1.2.0)
    Installing openssh (1.1.4)
    Installing resolver (1.1.0)
    Installing ssh_known_hosts (0.7.4)
    Installing timezone (0.0.1)
    Installing sudo (1.2.10)
    Installing users (1.3.0)
    [~/code/cc-chef-repo] $

**6)** Install the librarian-chef bundle:

    [~/code/cc-chef-repo] $ bin/librarian-chef install
    NOGEMDEV:                              ztk
    NOGEMDEV:                    cucumber-chef
     NOCBDEV:                            users, {:git=>"git@github.com:zpatten/chef-cookbook-users.git"}
     NOCBDEV:                             sudo, {:git=>"git@github.com:zpatten/chef-cookbook-sudo.git"}
     NOCBDEV:                            users, {:git=>"git@github.com:zpatten/chef-cookbook-users.git"}
     NOCBDEV:                             sudo, {:git=>"git@github.com:zpatten/chef-cookbook-sudo.git"}
    Installing apache2 (1.6.0)
    Installing apt (1.9.2)
    Installing rsyslog (1.5.0)
    Installing bluepill (2.2.2)
    Installing build-essential (1.3.4)
    Installing cron (1.2.2)
    Installing chef-client (2.2.2)
    Installing yum (2.2.0)
    Installing erlang (1.2.0)
    Installing couchdb (2.4.0)
    Installing ucspi-tcp (1.0.0)
    Installing daemontools (1.0.0)
    Installing gecode (2.0.0)
    Installing chef_handler (1.1.4)
    Installing windows (1.8.8)
    Installing java (1.10.0)
    Installing ohai (1.1.8)
    Installing nginx (1.4.0)
    Installing openssl (1.0.2)
    Installing runit (1.1.2)
    Installing xml (1.1.2)
    Installing zlib (2.0.0)
    Installing chef-server (1.1.0)
    Installing dmg (1.1.0)
    Installing git (2.4.0)
    Installing motd-tail (1.2.0)
    Installing openssh (1.1.4)
    Installing resolver (1.1.0)
    Installing ssh_known_hosts (0.7.4)
    Installing timezone (0.0.1)
    Installing sudo (1.2.10)
    Installing users (1.3.0)
    [~/code/cc-chef-repo] $

**7)** Ensure any existing test labs are destroyed:

    [~/code/cc-chef-repo] $ echo "yes" | bin/cucumber-chef destroy
    NOGEMDEV:                              ztk
    NOGEMDEV:                    cucumber-chef
    cucumber-chef v3.0.8
    +-------------------------------------------------+
    |    PROVIDER: Cucumber::Chef::Provider::Vagrant  |
    |          ID: test-lab-zpatten                   |
    |       STATE: unknown                            |
    |    USERNAME: vagrant                            |
    |  IP_ADDRESS: 192.168.33.10                      |
    |    SSH_PORT: 22                                 |
    +-------------------------------------------------+
    Are you sure you want to destroy the test lab?
    You have 5 seconds to abort!

    5...4...3...2...1...BOOM!

    Destroy VAGRANT instance 'test-lab-zpatten' completed in 1.2252 seconds.

    [~/code/cc-chef-repo] $

**8)** Setup a new test lab:

    [~/code/cc-chef-repo] $ bin/cucumber-chef setup
    NOGEMDEV:                              ztk
    NOGEMDEV:                    cucumber-chef
    cucumber-chef v3.0.8
    Creating VAGRANT instance completed in 79.4110 seconds.
    Uploading embedded chef-repo completed in 0.9761 seconds.
    Bootstrapping VAGRANT instance completed in 361.4017 seconds.
    Waiting for the chef-server-api HTTPS responded after 0.1005 seconds.
    Downloading chef credentials completed in 0.4057 seconds.
    Downloading SSH credentials completed in 0.8045 seconds.
    Rebooting the test lab completed in 45.1487 seconds.
    Waiting for the chef-server-api HTTPS responded after 0.1006 seconds.

    If you are using AWS, be sure to log into the chef-server webui and change the default admin password at least.

    Your test lab has now been provisioned!  Enjoy!

    +-------------------------------------------------+
    |    PROVIDER: Cucumber::Chef::Provider::Vagrant  |
    |          ID: test-lab-zpatten                   |
    |       STATE: running                            |
    |    USERNAME: vagrant                            |
    |  IP_ADDRESS: 192.168.33.10                      |
    |    SSH_PORT: 22                                 |
    +-------------------------------------------------+

    [~/code/cc-chef-repo] $

**9)** Run cucumber:



# RESOURCES

Source:

* https://github.com/zpatten/cc-chef-repo

Issues:

* https://github.com/zpatten/cc-chef-repo/issues

# LICENSE

cc-chef-repo - A example Chef-Repo to illustrate Cucumber-Chef usage

* Author: Zachary Patten <zachary@jovelabs.com> [![endorse](http://api.coderwall.com/zpatten/endorsecount.png)](http://coderwall.com/zpatten)
* Copyright: Copyright (c) Zachary Patten
* License: Apache License, Version 2.0

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
