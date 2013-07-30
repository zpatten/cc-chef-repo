@chef-client
Feature: Chef-Client Role
  In order to automate server provisioning with Opscode Chef
  As a DevOp Engineer
  I want to ensure that chef-client is daemonized on my servers

  Background:
    * I ssh to "mongo-01" with the following credentials:
      | username | keyfile |
      | $lxc$ | $lxc$ |

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