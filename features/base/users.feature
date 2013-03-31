@base @users
Feature: Base Role User Management
  In order to automate user management with Opscode Chef
  As a DevOp Engineer
  I want to ensure that my users are being managed properly

  Background:
    * I ssh to "devop-test-1" with the following credentials:
      | username | keyfile |
      | $lxc$ | $lxc$ |

  Scenario: The deployer user exists
    When I run "cat /etc/passwd | grep [d]eployer"
      Then I should see "deployer" in the output
      And I should see "/home/deployer" in the output
      And I should see "/bin/bash" in the output

  Scenario: The deployer users groups exist
    When I run "cat /etc/group | grep [d]eployer"
      Then I should see "devop" in the output
      Then I should see "deployer" in the output

  Scenario: The deployer users authorized_keys has been rendered
    When I run "cat /home/deployer/.ssh/authorized_keys"
      Then I should see "ssh-rsa" in the output
      And I should see "deployer" in the output

  Scenario: The deployer users ssh config has been rendered
    When I run "cat /home/deployer/.ssh/config"
      Then I should see "KeepAlive yes" in the output
      And I should see "ServerAliveInterval 60" in the output

  @ignore
  Scenario: The deployer user can ssh to the devop-test-1
    * I ssh to "devop-test-1" with the following credentials:
      | username | keyfile |
      | deployer | features/support/keys/deployer |
    When I run "whoami"
    Then I should see "deployer" in the output

