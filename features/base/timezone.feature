@base @timezone
Feature: Base Role TZ Management
  In order to automate TZ management with Opscode Chef
  As a DevOp Engineer
  I want to ensure that the hosts timezone is being managed properly

  Background:
    * I ssh to "devop-test-1" with the following credentials:
      | username | keyfile |
      | $lxc$ | $lxc$ |

  Scenario: System timezone is set and defaults to UTC.
    And I run "cat /etc/timezone"
    Then the exit code should be "0"
    And I should see "UTC" in the output
