[![Dependency Status](https://gemnasium.com/zpatten/cc-chef-repo.png)](https://gemnasium.com/zpatten/cc-chef-repo)

# OVERVIEW

This is an example `chef-repo` meant to illustrate the usage of cucumber-chef.  ENJOY!

# USING

#### 1) I define these bash aliases for use with my ruby-related development:

You do not need to use these; but if you want to use some of the more advanced features of this repo like gem and cookbook development; i.e. working on cucumber-chef for example; then you will want to use these.

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

#### 2) Clone this repo:

    [~] $ mkdir -p ~/code/
    [~] $ cd ~/code/
    [~/code] $ git clone git@github.com:zpatten/cc-chef-repo.git

#### 3) Change to the repo directory and make sure the ruby and gemset specified in `.ruby-version` and `.ruby-gemset` are active.  Optionally set `VERBOSE=1`.

    [~/code] $ cd cc-chef-repo
    [~/code/cc-chef-repo] $ export VERBOSE=1

#### TL;DR

At this point you have two options, keep going step by step or you can use this TL;DR version, you will need my bash aliases active for this version to work:

    rgs && bu && bibs && echo "y" | bin/cucumber-chef destroy && bin/cucumber-chef setup && bin/librarian-chef install && bin/cucumber

Alternately you can use this command if you don't want to bother with the aliases.  If you are not using RVM, you will have to adapt this command for whatever you using:

    rvm --force gemset empty && bundle update && bundle install --binstubs && echo "y" | bin/cucumber-chef destroy && bin/cucumber-chef setup && bin/librarian-chef install && bin/cucumber

#### 4) Reset your gemset, bundle update, bundle install binstubs:

If you are not using RVM, you will have to adapt the following command for whatever you using.

    [~/code/cc-chef-repo] $ rvm --force gemset empty && bundle update && bundle install --binstubs
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

#### 5) Update the librarian-chef bundle:

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

#### 6) Install the librarian-chef bundle:

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

#### 7) Ensure any existing test labs are destroyed:

    [~/code/cc-chef-repo] $ echo "y" | bin/cucumber-chef destroy
    NOGEMDEV:                              ztk
    NOGEMDEV:                    cucumber-chef
    cucumber-chef v3.0.8
    +-------------------------------------------------+
    |    PROVIDER: Cucumber::Chef::Provider::Vagrant  |
    |          ID: test-lab-zpatten                   |
    |       STATE: running                            |
    |    USERNAME: vagrant                            |
    |  IP_ADDRESS: 192.168.33.10                      |
    |    SSH_PORT: 22                                 |
    +-------------------------------------------------+
    Are you sure you want to destroy the test lab?
    You have 5 seconds to abort!

    5...4...3...2...1...BOOM!

    Destroy VAGRANT instance 'test-lab-zpatten' completed in 4.8374 seconds.

    [~/code/cc-chef-repo] $

#### 8) Setup a new test lab:

    [~/code/cc-chef-repo] $ bin/cucumber-chef setup
    NOGEMDEV:                              ztk
    NOGEMDEV:                    cucumber-chef
    cucumber-chef v3.0.8
    Creating VAGRANT instance completed in 93.9351 seconds.
    Uploading embedded chef-repo completed in 0.8683 seconds.
    Bootstrapping VAGRANT instance completed in 512.1306 seconds.
    Waiting for the chef-server-api HTTPS responded after 0.1005 seconds.
    Downloading chef credentials completed in 0.3048 seconds.
    Downloading SSH credentials completed in 0.7068 seconds.
    Rebooting the test lab completed in 28.2183 seconds.
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

#### 9) Run cucumber:

The first time a container is created for a particular distro/release pair it will take a while.  Once this first time 'cache' is created container creation becomes a very rapid process.

    [~/code/cc-chef-repo] $ bin/cucumber
    NOGEMDEV:                              ztk
    NOGEMDEV:                    cucumber-chef
    Using the default profile...
    Code:
      * features/support/env.rb
      * features/support/cc-hooks.rb
    >>> cucumber-chef v3.0.8
    >>> Pushing chef-repo environments to the test lab completed in 1.8293 seconds.
    >>> Pushing chef-repo cookbooks to the test lab completed in 15.5206 seconds.
    >>> Pushing chef-repo roles to the test lab completed in 1.0124 seconds.
    >>> Pushing chef-repo data bag 'users' to the test lab completed in 1.4156 seconds.
    >>> Creating container 'devop-test-1' completed in 511.7403 seconds.
    >>> Provisioning container 'devop-test-1' completed in 37.2049 seconds.

    Features:
      * features/base/sudo.feature
      * features/base/timezone.feature
      * features/base/users.feature
      * features/chef-client.feature
    Parsing feature files took 0m0.038s

    @base @sudo
    Feature: Base Role Sudo Management
      In order to automate user management with Opscode Chef
      As a DevOp Engineer
      I want to ensure that the deployer users sudo access is being managed properly

      Background:                                                 # features/base/sudo.feature:7
        * I ssh to "devop-test-1" with the following credentials: # cucumber-chef-3.0.8/lib/cucumber/chef/steps/ssh_steps.rb:28
          | username | keyfile |
          | $lxc$    | $lxc$   |

      Scenario: Our suoders file exists                           # features/base/sudo.feature:12
        When I run "[[ -e /etc/sudoers ]]"                        # cucumber-chef-3.0.8/lib/cucumber/chef/steps/ssh_steps.rb:62
        Then the exit code should be "0"                          # cucumber-chef-3.0.8/lib/cucumber/chef/steps/ssh_steps.rb:84

      Scenario: The deployer users groups should be in the sudoers file # features/base/sudo.feature:16
        When I run "grep [d]eployer /etc/sudoers"                       # cucumber-chef-3.0.8/lib/cucumber/chef/steps/ssh_steps.rb:62
        Then the exit code should be "0"                                # cucumber-chef-3.0.8/lib/cucumber/chef/steps/ssh_steps.rb:84
        And I should see "ALL" in the output                            # cucumber-chef-3.0.8/lib/cucumber/chef/steps/ssh_steps.rb:68
        And I should see "NOPASSWD" in the output                       # cucumber-chef-3.0.8/lib/cucumber/chef/steps/ssh_steps.rb:68
        When I run "grep [d]evop /etc/sudoers"                          # cucumber-chef-3.0.8/lib/cucumber/chef/steps/ssh_steps.rb:62
        Then the exit code should be "0"                                # cucumber-chef-3.0.8/lib/cucumber/chef/steps/ssh_steps.rb:84
        And I should see "ALL" in the output                            # cucumber-chef-3.0.8/lib/cucumber/chef/steps/ssh_steps.rb:68
        And I should see "NOPASSWD" in the output                       # cucumber-chef-3.0.8/lib/cucumber/chef/steps/ssh_steps.rb:68

    @base @timezone
    Feature: Base Role TZ Management
      In order to automate TZ management with Opscode Chef
      As a DevOp Engineer
      I want to ensure that the hosts timezone is being managed properly

      Background:                                                 # features/base/timezone.feature:7
        * I ssh to "devop-test-1" with the following credentials: # cucumber-chef-3.0.8/lib/cucumber/chef/steps/ssh_steps.rb:28
          | username | keyfile |
          | $lxc$    | $lxc$   |

      Scenario: System timezone is set and defaults to UTC.       # features/base/timezone.feature:12
        And I run "cat /etc/timezone"                             # cucumber-chef-3.0.8/lib/cucumber/chef/steps/ssh_steps.rb:62
        Then the exit code should be "0"                          # cucumber-chef-3.0.8/lib/cucumber/chef/steps/ssh_steps.rb:84
        And I should see "UTC" in the output                      # cucumber-chef-3.0.8/lib/cucumber/chef/steps/ssh_steps.rb:68

    @base @users
    Feature: Base Role User Management
      In order to automate user management with Opscode Chef
      As a DevOp Engineer
      I want to ensure that my users are being managed properly

      Background:                                                 # features/base/users.feature:7
        * I ssh to "devop-test-1" with the following credentials: # cucumber-chef-3.0.8/lib/cucumber/chef/steps/ssh_steps.rb:28
          | username | keyfile |
          | $lxc$    | $lxc$   |

      Scenario: The deployer user exists                          # features/base/users.feature:12
        When I run "cat /etc/passwd | grep [d]eployer"            # cucumber-chef-3.0.8/lib/cucumber/chef/steps/ssh_steps.rb:62
        Then the exit code should be "0"                          # cucumber-chef-3.0.8/lib/cucumber/chef/steps/ssh_steps.rb:84
        And I should see "deployer" in the output                 # cucumber-chef-3.0.8/lib/cucumber/chef/steps/ssh_steps.rb:68
        And I should see "/home/deployer" in the output           # cucumber-chef-3.0.8/lib/cucumber/chef/steps/ssh_steps.rb:68
        And I should see "/bin/bash" in the output                # cucumber-chef-3.0.8/lib/cucumber/chef/steps/ssh_steps.rb:68

      Scenario: The deployer users groups exist                   # features/base/users.feature:19
        When I run "cat /etc/group | grep [d]eployer"             # cucumber-chef-3.0.8/lib/cucumber/chef/steps/ssh_steps.rb:62
        Then the exit code should be "0"                          # cucumber-chef-3.0.8/lib/cucumber/chef/steps/ssh_steps.rb:84
        And I should see "devop" in the output                    # cucumber-chef-3.0.8/lib/cucumber/chef/steps/ssh_steps.rb:68
        And I should see "deployer" in the output                 # cucumber-chef-3.0.8/lib/cucumber/chef/steps/ssh_steps.rb:68

      Scenario: The deployer users authorized_keys has been rendered # features/base/users.feature:25
        When I run "cat /home/deployer/.ssh/authorized_keys"         # cucumber-chef-3.0.8/lib/cucumber/chef/steps/ssh_steps.rb:62
        Then the exit code should be "0"                             # cucumber-chef-3.0.8/lib/cucumber/chef/steps/ssh_steps.rb:84
        And I should see "ssh-rsa" in the output                     # cucumber-chef-3.0.8/lib/cucumber/chef/steps/ssh_steps.rb:68
        And I should see "deployer" in the output                    # cucumber-chef-3.0.8/lib/cucumber/chef/steps/ssh_steps.rb:68

      Scenario: The deployer users ssh config has been rendered   # features/base/users.feature:31
        When I run "cat /home/deployer/.ssh/config"               # cucumber-chef-3.0.8/lib/cucumber/chef/steps/ssh_steps.rb:62
        Then the exit code should be "0"                          # cucumber-chef-3.0.8/lib/cucumber/chef/steps/ssh_steps.rb:84
        And I should see "KeepAlive yes" in the output            # cucumber-chef-3.0.8/lib/cucumber/chef/steps/ssh_steps.rb:68
        And I should see "ServerAliveInterval 60" in the output   # cucumber-chef-3.0.8/lib/cucumber/chef/steps/ssh_steps.rb:68

      Scenario: The deployer user can ssh to the devop-test-1     # features/base/users.feature:37
        * I ssh to "devop-test-1" with the following credentials: # cucumber-chef-3.0.8/lib/cucumber/chef/steps/ssh_steps.rb:28
          | username | keyfile                        |
          | deployer | features/support/keys/deployer |
        When I run "whoami"                                       # cucumber-chef-3.0.8/lib/cucumber/chef/steps/ssh_steps.rb:62
        Then the exit code should be "0"                          # cucumber-chef-3.0.8/lib/cucumber/chef/steps/ssh_steps.rb:84
        And I should see "deployer" in the output                 # cucumber-chef-3.0.8/lib/cucumber/chef/steps/ssh_steps.rb:68

    @chef-client
    Feature: Chef-Client Role
      In order to automate server provisioning with Opscode Chef
      As a DevOp Engineer
      I want to ensure that chef-client is daemonized on my servers

      Background:                                                 # features/chef-client.feature:7
        * I ssh to "devop-test-1" with the following credentials: # cucumber-chef-3.0.8/lib/cucumber/chef/steps/ssh_steps.rb:28
          | username | keyfile |
          | $lxc$    | $lxc$   |

      Scenario: Chef-Client is running as a daemon                # features/chef-client.feature:12
        When I run "ps aux | grep [c]hef-client"                  # cucumber-chef-3.0.8/lib/cucumber/chef/steps/ssh_steps.rb:62
        Then the exit code should be "0"                          # cucumber-chef-3.0.8/lib/cucumber/chef/steps/ssh_steps.rb:84
        And I should see "chef-client" in the output              # cucumber-chef-3.0.8/lib/cucumber/chef/steps/ssh_steps.rb:68
        And I should see "-i 900" in the output                   # cucumber-chef-3.0.8/lib/cucumber/chef/steps/ssh_steps.rb:68
        And I should see "-s 900" in the output                   # cucumber-chef-3.0.8/lib/cucumber/chef/steps/ssh_steps.rb:68

      Scenario: The Chef-Server validation key has been removed   # features/chef-client.feature:19
        When I run "[[ ! -e /etc/chef/validation.pem ]]"          # cucumber-chef-3.0.8/lib/cucumber/chef/steps/ssh_steps.rb:62
        Then the exit code should be "0"                          # cucumber-chef-3.0.8/lib/cucumber/chef/steps/ssh_steps.rb:84

    10 scenarios (10 passed)
    51 steps (51 passed)
    0m3.630s
    [~/code/cc-chef-repo] $

#### 10) Container Status

Lets see how the container is doing after the test:

    [~/code/cc-chef-repo] $ bin/cucumber-chef status --containers
    NOGEMDEV:                              ztk
    NOGEMDEV:                    cucumber-chef
    cucumber-chef v3.0.8
    +--------------+-------+--------+-------------+-------------------+---------------+---------+
    | NAME         | ALIVE | DISTRO | IP          | MAC               | CHEF VERSION  | PERSIST |
    +--------------+-------+--------+-------------+-------------------+---------------+---------+
    | devop-test-1 | true  | ubuntu | 192.168.0.1 | 00:00:5e:35:ea:d5 | Chef: 10.24.0 | true    |
    +--------------+-------+--------+-------------+-------------------+---------------+---------+

    [~/code/cc-chef-repo] $

Looks good!

#### 11) Container SSH

Lets checkout the container itself:

    [~/code/cc-chef-repo] $ bin/cucumber-chef ssh devop-test-1
    NOGEMDEV:                              ztk
    NOGEMDEV:                    cucumber-chef
    cucumber-chef v3.0.8
    Attempting proxy SSH connection to the container 'devop-test-1'...
          _____                           _                _____ _           __
         / ____|                         | |              / ____| |         / _|
        | |    _   _  ___ _   _ _ __ ___ | |__   ___ _ __| |    | |__   ___| |_
        | |   | | | |/ __| | | | '_ ` _ \| '_ \ / _ \ '__| |    | '_ \ / _ \  _|
        | |___| |_| | (__| |_| | | | | | | |_) |  __/ |  | |____| | | |  __/ |
         \_____\__,_|\___|\__,_|_| |_| |_|_.__/ \___|_|   \_____|_| |_|\___|_|


        Welcome to the Cucumber Chef Test Lab v3.0.8

        You are now logged in to the devop-test-1 container!

    Last login: Sun Apr 14 22:12:24 2013 from cucumber-chef.test-lab
    root@devop-test-1:~#

Nice! We're in!

##### 12) Process List

Lets see what's running; we can pass our own `ps` options in too; I like using `aux`:

    [~/code/cc-chef-repo] $ bin/cucumber-chef ps aux
    NOGEMDEV:                              ztk
    NOGEMDEV:                    cucumber-chef
    cucumber-chef v3.0.8
    --------------------------------------------------------------------------------
    CONTAINER  USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
    devop-test-1 root     24034  0.0  0.0  23920  1892 ?        Ss   22:09   0:00 /sbin/init
    devop-test-1 root     24170  0.0  0.0  16964   364 ?        S    22:09   0:00 upstart-udev-bridge --daemon
    devop-test-1 syslog   24179  0.0  0.0 119872  1412 ?        Sl   22:09   0:00 rsyslogd -c4
    devop-test-1 root     24184  0.0  0.0  16812   420 ?        S<s  22:09   0:00 udevd --daemon
    devop-test-1 root     24196  0.0  0.0   6140   636 pts/5    Ss+  22:09   0:00 /sbin/getty -8 38400 tty4
    devop-test-1 root     24199  0.0  0.0   6140   636 pts/3    Ss+  22:09   0:00 /sbin/getty -8 38400 tty2
    devop-test-1 root     24200  0.0  0.0   6140   640 pts/4    Ss+  22:09   0:00 /sbin/getty -8 38400 tty3
    devop-test-1 root     24207  0.0  0.0  21136   896 ?        Ss   22:09   0:00 cron
    devop-test-1 root     24241  0.0  0.0   6140   636 pts/2    Ss+  22:09   0:00 /sbin/getty -8 38400 tty1
    devop-test-1 root     24243  0.0  0.0   6140   636 pts/6    Ss+  22:09   0:00 /sbin/getty -8 38400 /dev/console
    devop-test-1 root     24265  0.0  0.0   6616   288 ?        Ss   22:09   0:00 dhclient3 -e IF_METRIC=100 -pf /var/run/dhclient.eth0.pid -lf /var/lib/dhcp3/dhclient.eth0.leases eth0
    devop-test-1 root     24281  0.0  0.0  49324  2544 ?        Ss   22:09   0:00 /usr/sbin/sshd -D
    devop-test-1 root     24905  0.0  0.7 111136 30996 ?        Sl   22:10   0:00 /opt/chef/embedded/bin/ruby /usr/bin/chef-client -d -P /var/run/chef/client.pid -c /etc/chef/client.rb -i 900 -s 900 -L /var/log/chef/client.log
    --------------------------------------------------------------------------------

    [~/code/cc-chef-repo] $

We can see our `chef-client` daemon up and running along with some other standard daemons and processes.


I hope this helps further use and understanding of test-driven infrastructure and cucumber-chef!

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
