@csvlint @mysql
Feature: mysql server role
  In order to run csvlint.io
  I want a mysql server

  Background:
    * I ssh to "mysql-csvlint-cucumber" with the following credentials:
      | username | keyfile |
      | $lxc$    | $lxc$   |

  Scenario: MySQL is installed
    * package "mysql-server" should be installed

#  Scenario: Can connect to database server
#    When I run "mysql -p'passwordbeallfakeforjuvia' -e 'show databases'"
#    Then I should not see "ERROR" in the output

#  Scenario: Database "csvlint" exists
#    When I run "mysql -p'passwordbeallfakeforjuvia' -e 'show databases'"
#    Then I should see "csvlint" in the output