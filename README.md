# OVERVIEW

This is an example `chef-repo` meant to illustrate the usage of cucumber-chef.  ENJOY!

# Using

1) I define these bash aliases for use with my ruby-related development:

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

2) Clone this repo:

    [~] $ mkdir -p ~/code/
    [~] $ cd ~/code/
    [~/code] $ git clone git@github.com:zpatten/cc-chef-repo.git

3) Change to the repo directory and make sure the ruby and gemset specified in `.ruby-version` and `.ruby-gemset` are active.  Optionally set VERBOSE=1.

    [~/code] $ cd cc-chef-repo
    [~/code/cc-chef-repo] $ export VERBOSE=1

4) Clear your gemset, bundle update, bundle install binstubs:

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

5) Update the librarian-chef bundle:

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

6) Install the librarian-chef bundle:

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

7) Ensure any existing test labs are destroyed:

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

8) Setup a new test lab:




# Cucumber-Chef v3.0.6 Run

    $ rvm --force gemset empty && bundle install --binstubs && echo "yes" | bin/cucumber-chef destroy && bin/cucumber-chef setup && time bin/cucumber
    NOGEMDEV:                              ztk
    NOGEMDEV:                    cucumber-chef
    NOGEMDEV:                              ztk
    NOGEMDEV:                    cucumber-chef
    Fetching gem metadata from https://rubygems.org/.........
    Fetching gem metadata from https://rubygems.org/..
    Installing rake (10.0.4)
    Installing i18n (0.6.1)
    Installing multi_json (1.7.2)
    Installing activesupport (3.2.13)
    Installing archive-tar-minitar (0.5.2)
    Installing builder (3.2.0)
    Installing bunny (0.7.9)
    Installing erubis (2.7.0)
    Installing highline (1.6.16)
    Installing json (1.7.7) with native extensions
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
    Installing yajl-ruby (1.1.0) with native extensions
    Installing ohai (6.16.0)
    Installing mime-types (1.22)
    Installing rest-client (1.6.7)
    Installing polyglot (0.3.3)
    Installing treetop (1.4.12)
    Installing uuidtools (2.1.3)
    Installing chef (10.24.0)
    Installing diff-lcs (1.2.3)
    Installing gherkin (2.11.8) with native extensions
    Installing cucumber (1.2.5)
    Installing excon (0.20.1)
    Installing formatador (0.2.4)
    Installing net-scp (1.1.0)
    Installing nokogiri (1.5.9) with native extensions
    Installing ruby-hmac (0.4.0)
    Installing fog (1.10.1)
    Installing rspec-core (2.13.1)
    Installing rspec-expectations (2.13.0)
    Installing rspec-mocks (2.13.1)
    Installing rspec (2.13.0)
    Installing thor (0.18.1)
    Installing ubuntu_ami (0.4.1)
    Installing net-sftp (2.1.1)
    Installing ztk (1.0.10)
    Installing cucumber-chef (3.0.6)
    Installing librarian (0.1.0)
    Installing librarian-chef (0.0.1)
    Using bundler (1.2.3)
    Your bundle is complete! Use `bundle show [gemname]` to see where a bundled gem is installed.
    Post-install message from bunny:
    [Version 0.7.8] test suite cleanup (eliminated some race conditions related to queue.message_count)

    NOGEMDEV:                              ztk
    NOGEMDEV:                    cucumber-chef
    cucumber-chef v3.0.6
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

    Destroy VAGRANT instance 'test-lab-zpatten' completed in 2.2374 seconds.

    NOGEMDEV:                              ztk
    NOGEMDEV:                    cucumber-chef
    cucumber-chef v3.0.6
    Creating VAGRANT instance completed in 112.3682 seconds.
    Uploading embedded chef-repo completed in 0.9657 seconds.
    Bootstrapping VAGRANT instance completed in 237.7720 seconds.
    Waiting for the chef-server-api HTTPS responded after 0.1005 seconds.
    Downloading chef credentials completed in 0.3062 seconds.
    Downloading SSH credentials completed in 0.9147 seconds.
    Rebooting the test lab completed in 89.1921 seconds.
    Waiting for the chef-server-api HTTPS responded after 0.1005 seconds.

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

    NOGEMDEV:                              ztk
    NOGEMDEV:                    cucumber-chef
    Using the default profile...
    Code:
      * features/support/env.rb
      * features/support/cc-hooks.rb
    >>> cucumber-chef v3.0.6
    >>> Pushing chef-repo environments to the test lab completed in 1.7292 seconds.
    >>> Pushing chef-repo cookbooks to the test lab completed in 29.5274 seconds.
    >>> Pushing chef-repo roles to the test lab completed in 1.0046 seconds.
    >>> Pushing chef-repo data bag 'users' to the test lab completed in 1.7133 seconds.
    >>> Creating container 'devop-test-1' completed in 528.2874 seconds.
    >>> Provisioning container 'devop-test-1' completed in 42.1745 seconds.

    Features:
      * features/base/sudo.feature
      * features/base/timezone.feature
      * features/base/users.feature
      * features/chef-client.feature
    Parsing feature files took 0m0.032s

    @base @sudo
    Feature: Base Role Sudo Management
      In order to automate user management with Opscode Chef
      As a DevOp Engineer
      I want to ensure that the deployer users sudo access is being managed properly

      Background:                                                 # features/base/sudo.feature:7
        * I ssh to "devop-test-1" with the following credentials: # cucumber-chef-3.0.6/lib/cucumber/chef/steps/ssh_steps.rb:28
          | username | keyfile |
          | $lxc$    | $lxc$   |

      Scenario: Our suoders file exists                           # features/base/sudo.feature:12
        When I run "[[ -e /etc/sudoers ]]"                        # cucumber-chef-3.0.6/lib/cucumber/chef/steps/ssh_steps.rb:62
        Then the exit code should be "0"                          # cucumber-chef-3.0.6/lib/cucumber/chef/steps/ssh_steps.rb:84

      Scenario: The deployer users groups should be in the sudoers file # features/base/sudo.feature:16
        When I run "grep [d]eployer /etc/sudoers"                       # cucumber-chef-3.0.6/lib/cucumber/chef/steps/ssh_steps.rb:62
        Then the exit code should be "0"                                # cucumber-chef-3.0.6/lib/cucumber/chef/steps/ssh_steps.rb:84
        And I should see "ALL" in the output                            # cucumber-chef-3.0.6/lib/cucumber/chef/steps/ssh_steps.rb:68
        And I should see "NOPASSWD" in the output                       # cucumber-chef-3.0.6/lib/cucumber/chef/steps/ssh_steps.rb:68
        When I run "grep [d]evop /etc/sudoers"                          # cucumber-chef-3.0.6/lib/cucumber/chef/steps/ssh_steps.rb:62
        Then the exit code should be "0"                                # cucumber-chef-3.0.6/lib/cucumber/chef/steps/ssh_steps.rb:84
        And I should see "ALL" in the output                            # cucumber-chef-3.0.6/lib/cucumber/chef/steps/ssh_steps.rb:68
        And I should see "NOPASSWD" in the output                       # cucumber-chef-3.0.6/lib/cucumber/chef/steps/ssh_steps.rb:68

    @base @timezone
    Feature: Base Role TZ Management
      In order to automate TZ management with Opscode Chef
      As a DevOp Engineer
      I want to ensure that the hosts timezone is being managed properly

      Background:                                                 # features/base/timezone.feature:7
        * I ssh to "devop-test-1" with the following credentials: # cucumber-chef-3.0.6/lib/cucumber/chef/steps/ssh_steps.rb:28
          | username | keyfile |
          | $lxc$    | $lxc$   |

      Scenario: System timezone is set and defaults to UTC.       # features/base/timezone.feature:12
        And I run "cat /etc/timezone"                             # cucumber-chef-3.0.6/lib/cucumber/chef/steps/ssh_steps.rb:62
        Then the exit code should be "0"                          # cucumber-chef-3.0.6/lib/cucumber/chef/steps/ssh_steps.rb:84
        And I should see "UTC" in the output                      # cucumber-chef-3.0.6/lib/cucumber/chef/steps/ssh_steps.rb:68

    @base @users
    Feature: Base Role User Management
      In order to automate user management with Opscode Chef
      As a DevOp Engineer
      I want to ensure that my users are being managed properly

      Background:                                                 # features/base/users.feature:7
        * I ssh to "devop-test-1" with the following credentials: # cucumber-chef-3.0.6/lib/cucumber/chef/steps/ssh_steps.rb:28
          | username | keyfile |
          | $lxc$    | $lxc$   |

      Scenario: The deployer user exists                          # features/base/users.feature:12
        When I run "cat /etc/passwd | grep [d]eployer"            # cucumber-chef-3.0.6/lib/cucumber/chef/steps/ssh_steps.rb:62
        Then the exit code should be "0"                          # cucumber-chef-3.0.6/lib/cucumber/chef/steps/ssh_steps.rb:84
        And I should see "deployer" in the output                 # cucumber-chef-3.0.6/lib/cucumber/chef/steps/ssh_steps.rb:68
        And I should see "/home/deployer" in the output           # cucumber-chef-3.0.6/lib/cucumber/chef/steps/ssh_steps.rb:68
        And I should see "/bin/bash" in the output                # cucumber-chef-3.0.6/lib/cucumber/chef/steps/ssh_steps.rb:68

      Scenario: The deployer users groups exist                   # features/base/users.feature:19
        When I run "cat /etc/group | grep [d]eployer"             # cucumber-chef-3.0.6/lib/cucumber/chef/steps/ssh_steps.rb:62
        Then the exit code should be "0"                          # cucumber-chef-3.0.6/lib/cucumber/chef/steps/ssh_steps.rb:84
        And I should see "devop" in the output                    # cucumber-chef-3.0.6/lib/cucumber/chef/steps/ssh_steps.rb:68
        And I should see "deployer" in the output                 # cucumber-chef-3.0.6/lib/cucumber/chef/steps/ssh_steps.rb:68

      Scenario: The deployer users authorized_keys has been rendered # features/base/users.feature:25
        When I run "cat /home/deployer/.ssh/authorized_keys"         # cucumber-chef-3.0.6/lib/cucumber/chef/steps/ssh_steps.rb:62
        Then the exit code should be "0"                             # cucumber-chef-3.0.6/lib/cucumber/chef/steps/ssh_steps.rb:84
        And I should see "ssh-rsa" in the output                     # cucumber-chef-3.0.6/lib/cucumber/chef/steps/ssh_steps.rb:68
        And I should see "deployer" in the output                    # cucumber-chef-3.0.6/lib/cucumber/chef/steps/ssh_steps.rb:68

      Scenario: The deployer users ssh config has been rendered   # features/base/users.feature:31
        When I run "cat /home/deployer/.ssh/config"               # cucumber-chef-3.0.6/lib/cucumber/chef/steps/ssh_steps.rb:62
        Then the exit code should be "0"                          # cucumber-chef-3.0.6/lib/cucumber/chef/steps/ssh_steps.rb:84
        And I should see "KeepAlive yes" in the output            # cucumber-chef-3.0.6/lib/cucumber/chef/steps/ssh_steps.rb:68
        And I should see "ServerAliveInterval 60" in the output   # cucumber-chef-3.0.6/lib/cucumber/chef/steps/ssh_steps.rb:68

      Scenario: The deployer user can ssh to the devop-test-1     # features/base/users.feature:37
        * I ssh to "devop-test-1" with the following credentials: # cucumber-chef-3.0.6/lib/cucumber/chef/steps/ssh_steps.rb:28
          | username | keyfile                        |
          | deployer | features/support/keys/deployer |
        When I run "whoami"                                       # cucumber-chef-3.0.6/lib/cucumber/chef/steps/ssh_steps.rb:62
        Then the exit code should be "0"                          # cucumber-chef-3.0.6/lib/cucumber/chef/steps/ssh_steps.rb:84
        And I should see "deployer" in the output                 # cucumber-chef-3.0.6/lib/cucumber/chef/steps/ssh_steps.rb:68

    @chef-client
    Feature: Chef-Client Role
      In order to automate server provisioning with Opscode Chef
      As a DevOp Engineer
      I want to ensure that chef-client is daemonized on my servers

      Background:                                                 # features/chef-client.feature:7
        * I ssh to "devop-test-1" with the following credentials: # cucumber-chef-3.0.6/lib/cucumber/chef/steps/ssh_steps.rb:28
          | username | keyfile |
          | $lxc$    | $lxc$   |

      Scenario: Chef-Client is running as a daemon                # features/chef-client.feature:12
        When I run "ps aux | grep [c]hef-client"                  # cucumber-chef-3.0.6/lib/cucumber/chef/steps/ssh_steps.rb:62
        Then the exit code should be "0"                          # cucumber-chef-3.0.6/lib/cucumber/chef/steps/ssh_steps.rb:84
        And I should see "chef-client" in the output              # cucumber-chef-3.0.6/lib/cucumber/chef/steps/ssh_steps.rb:68
        And I should see "-i 900" in the output                   # cucumber-chef-3.0.6/lib/cucumber/chef/steps/ssh_steps.rb:68
        And I should see "-s 900" in the output                   # cucumber-chef-3.0.6/lib/cucumber/chef/steps/ssh_steps.rb:68

      Scenario: The Chef-Server validation key has been removed   # features/chef-client.feature:19
        When I run "[[ ! -e /etc/chef/validation.pem ]]"          # cucumber-chef-3.0.6/lib/cucumber/chef/steps/ssh_steps.rb:62
        Then the exit code should be "0"                          # cucumber-chef-3.0.6/lib/cucumber/chef/steps/ssh_steps.rb:84

    10 scenarios (10 passed)
    51 steps (51 passed)
    0m4.001s

    real    10m11.078s
    user    0m14.547s
    sys 0m1.508s


    $ bin/cucumber-chef displayconfig
    NOGEMDEV:                              ztk
    NOGEMDEV:                    cucumber-chef
    cucumber-chef v3.0.6
    --------------------------------------------------------------------------------
    ---
    :mode: :user
    :prerelease: false
    :user: zpatten
    :artifacts:
      chef-client-log: /var/log/chef/client.log
      chef-client-stacktrace: /var/chef/cache/chef-stacktrace.out
    :chef:
      :version: latest
      :container_version: 10.24.0
      :default_password: p@ssw0rd1
      :render_client_rb: true
      :cookbook_paths:
      - cookbooks
      - site-cookbooks
      :prereleases: false
      :nightlies: false
    :test_lab:
      :hostname: cucumber-chef
      :tld: test-lab
    :command_timeout: 1800
    :provider: :vagrant
    :aws:
      :bootstrap_user: ubuntu
      :lab_user: cucumber-chef
      :lxc_user: root
      :ssh:
        :lab_port: 22
        :lxc_port: 22
      :ubuntu_release: precise
      :aws_instance_arch: i386
      :aws_instance_disk_store: ebs
      :aws_instance_type: c1.medium
      :aws_security_group: cucumber-chef
      :identity_file:
      :aws_access_key_id:
      :aws_secret_access_key:
      :aws_ssh_key_id:
      :region: us-west-2
      :availability_zone: us-west-2a
    :vagrant:
      :bootstrap_user: vagrant
      :lab_user: cucumber-chef
      :lxc_user: root
      :ssh:
        :lab_ip: 192.168.33.10
        :lab_port: 22
        :lxc_port: 22
      :cpus: 4
      :memory: 4096
      :identity_file: /home/zpatten/.vagrant.d/insecure_private_key

    --------------------------------------------------------------------------------
                   root_dir = "/home/zpatten/.rvm/gems/ruby-1.9.3-p392@cc-chef-repo/gems/cucumber-chef-3.0.6"
                   home_dir = "/home/zpatten/code/cc-chef-repo/.cucumber-chef"
                   log_file = "/home/zpatten/code/cc-chef-repo/.cucumber-chef/cucumber-chef.log"
              artifacts_dir = "/home/zpatten/code/cc-chef-repo/.cucumber-chef/vagrant/artifacts"
                  config_rb = "/home/zpatten/code/cc-chef-repo/.cucumber-chef/config.rb"
                    labfile = "/home/zpatten/code/cc-chef-repo/Labfile"
                  chef_repo = "/home/zpatten/code/cc-chef-repo"
                  chef_user = "zpatten"
              chef_identity = "/home/zpatten/code/cc-chef-repo/.cucumber-chef/vagrant/zpatten.pem"
             bootstrap_user = "vagrant"
    bootstrap_user_home_dir = "/home/vagrant"
         bootstrap_identity = "/home/zpatten/.vagrant.d/insecure_private_key"
                   lab_user = "cucumber-chef"
          lab_user_home_dir = "/home/cucumber-chef"
               lab_identity = "/home/zpatten/code/cc-chef-repo/.cucumber-chef/vagrant/id_rsa-cucumber-chef"
                   lxc_user = "root"
          lxc_user_home_dir = "/root"
               lxc_identity = "/home/zpatten/code/cc-chef-repo/.cucumber-chef/vagrant/id_rsa-root"
                chef_pre_11 = false
    --------------------------------------------------------------------------------


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
