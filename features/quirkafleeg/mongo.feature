@mongo
Feature: mongodb server role
  In order to run Quirkafleeg
  I want a mongodb server

  Background:
    * I ssh to "mongo-quirkafleeg-01" with the following credentials:
      | username | keyfile |
      | $lxc$    | $lxc$   |

  Scenario: Chef-Client is running as a daemon
    When I run "ps aux | grep [c]hef-client"
    Then the exit code should be "0"
    And I should see "chef-client" in the output
    And I should see "-i 900" in the output
    And I should see "-s 900" in the output

  Scenario: The Chef-Server validation key has been removed
    When I run "[[ ! -e /etc/chef/validation.pem ]]"
    Then the exit code should be "0"

  Scenario: postfix is installed
    * package "postfix" should be installed

  Scenario: ntp is installed
    When I run "ps ax | grep 'ntpd ' | grep -v grep"
    Then the exit code should be "0"

  Scenario: mongodb is installed
    * package "mongodb-10gen" should be installed

  Scenario: mongodb be runnin'
    * "mongod" should be running