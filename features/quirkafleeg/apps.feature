@apps
Feature: GDS apps
  In order to run Quirkafleeg
  I need some apps

  Background:
    * I ssh to "web-quirkafleeg-01" with the following credentials:
      | username | keyfile |
      | $lxc$    | $lxc$   |

  Scenario: signon exists
    * directory "/var/www/signon" should exist
    And directory "/var/www/signon/shared" should exist
    And directory "/var/www/signon/shared/log" should exist
    And directory "/var/www/signon/shared/log" should be owned by "quirkafleeg:quirkafleeg"

  Scenario: Assets have been compiled
    * directory "/var/www/signon/current/public/assets/" should exist

