@juvia

Feature: Build a juvia whatnot

  In order to facilitate lots of angry shouting
  On the internet
  I want to host a Juvia instance

  Background:
    * I ssh to "juvia" with the following credentials:
      | username | keyfile |
      | $lxc$    | $lxc$   |

  Scenario: Core dependencies are installed
    * package "build-essential" should be installed
    And package "git" should be installed
    And package "curl" should be installed

  Scenario: User 'juvia' exists
    When I run "su - juvia -c 'echo ${SHELL}'"
    Then I should see "/bin/bash" in the output

  Scenario: User can sudo with no password
  # we cannot test this properly on Vagrant!
  #  * I run "su - juvia -c 'sudo bash'"
  #  * I should not see "password for juvia" in the output
  # So we compromise with this
    * file "/etc/sudoers.d/juvia" should exist
    And file "/etc/sudoers.d/juvia" should contain
    """
juvia ALL=NOPASSWD:ALL
    """
    And file "/etc/sudoers" should contain
    """
#includedir /etc/sudoers.d
    """
    When I run "stat -c %a /etc/sudoers.d/juvia"
    Then I should see "440" in the output

  Scenario: Ruby 1.9.3 is installed
    When I run "su - juvia -c 'ruby -v'"
    Then I should see "1.9.3" in the output

  Scenario: code is deployed
    * directory "/var/www/juvia.theodi.org" should exist
    And directory "/var/www/juvia.theodi.org/shared" should exist
    And directory "/var/www/juvia.theodi.org/shared/log" should exist
    And directory "/var/www/juvia.theodi.org/shared/log" should be owned by "juvia:juvia"
