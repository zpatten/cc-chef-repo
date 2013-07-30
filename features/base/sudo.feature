@base @sudo
Feature: Base Role Sudo Management
  In order to automate user management with Opscode Chef
  As a DevOp Engineer
  I want to ensure that the deployer users sudo access is being managed properly

  Background:
    * I ssh to "mongo-01" with the following credentials:
      | username | keyfile |
      | $lxc$ | $lxc$ |

  Scenario: Our suoders file exists
    When I run "[[ -e /etc/sudoers ]]"
      Then the exit code should be "0"

  Scenario: The deployer users groups should be in the sudoers file
    When I run "grep [d]eployer /etc/sudoers"
      Then the exit code should be "0"
      And I should see "ALL" in the output
      And I should see "NOPASSWD" in the output
    When I run "grep [d]evop /etc/sudoers"
      Then the exit code should be "0"
      And I should see "ALL" in the output
      And I should see "NOPASSWD" in the output
