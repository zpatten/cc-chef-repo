@metrics-api @mongo
Feature: mongodb server role
  In order to run some metrics thing
  I want a mongodb server

  Background:
    * I ssh to "metrics-api" with the following credentials:
      | username | keyfile |
      | $lxc$    | $lxc$   |

  Scenario: The Chef-Server validation key has been removed
    When I run "[[ ! -e /etc/chef/validation.pem ]]"
    Then the exit code should be "0"

  Scenario: postfix is installed
    * package "postfix" should be installed

  Scenario: git is installed
    * package "git" should be installed

  Scenario: odi user exists
    When I run "su - odi -c 'echo ${SHELL}'"
    Then I should see "/bin/bash" in the output

  Scenario: ntp is installed
    When I run "ps ax | grep 'ntpd ' | grep -v grep"
    Then the exit code should be "0"

  Scenario: mongodb is installed
    * package "mongodb-10gen" should be installed

  Scenario: listening on specified ip address
    When I run "ps ax | grep mongo"
    Then I should see "--bind_ip 192.168.96.10,127.0.0.1" in the output

  Scenario: mongodb be runnin'
    * "mongod" should be running

  @chef-client
  Scenario: chef-client should be cronned
    When I run "cat /etc/cron.d/chef-client"
    Then I should see "^\*/5 .* /usr/bin/chef-client &> /var/log/chef/cron.log" in the output
    When I run "ps ax"
    Then I should not see "chef-client .* -i .* -s" in the output

  @user
  Scenario: hoppler user exists
    When I run "su - hoppler -c 'echo ${SHELL}'"
    Then I should see "/bin/bash" in the output

  @user
  Scenario: hoppler user has ruby 2
    When I run "su - hoppler -c 'ruby -v'"
    Then I should see "2.0.0" in the output

  @code
  Scenario: Hoppler is installed and cronned
    * path "/home/hoppler/hoppler" should exist
    And file "/home/hoppler/hoppler/lib/hoppler.rb" should exist
    And file "/etc/cron.d/hoppler" should contain
    """
0 2 * * * root su - hoppler -c 'cd /home/hoppler/hoppler && `which rake` hoppler:backup_mongo'
    """

#  Scenario: env is correct
#    When I run "cat /home/hoppler/hoppler/.local.env"
#    Then I should see "MONGO_HOST: 192.168.96.10" in the output