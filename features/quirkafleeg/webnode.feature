@web
Feature: web node role
  In order to run Quirkafleeg
  I need some webserver action

  Background:
    * I ssh to "web-quirkafleeg-01" with the following credentials:
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

  Scenario: git is installed
    * package "git" should be installed

#  Scenario: nginx is installed
#    * package "nginx" should be installed

  Scenario: a load of other dependencies are installed
    * package "libxml2-dev" should be installed
    And package "libxslt1-dev" should be installed
    And package "libmysqlclient-dev" should be installed
    And package "wbritish-large" should be installed
    And package "curl" should be installed
    And package "build-essential" should be installed
    When I run "node -h"
    Then I should not see "command not found" in the output

  Scenario: User 'quirkafleeg' exists
    When I run "su - quirkafleeg -c 'echo ${SHELL}'"
    Then I should see "/bin/bash" in the output

  Scenario: User can sudo with no password
  # we cannot test this properly on Vagrant!
  #  * I run "su - certificate -c 'sudo bash'"
  #  * I should not see "password for certificate" in the output
  # So we compromise with this
    * file "/etc/sudoers.d/quirkafleeg" should exist
    And file "/etc/sudoers.d/quirkafleeg" should contain
    """
quirkafleeg ALL=NOPASSWD:ALL
    """
    * file "/etc/sudoers" should contain
    """
#includedir /etc/sudoers.d
    """
    When I run "stat -c %a /etc/sudoers.d/quirkafleeg"
    Then I should see "440" in the output

  Scenario: Ruby 1.9.3 is installed
    * I run "su - quirkafleeg -c 'ruby -v'"
    * I should see "1.9.3" in the output
