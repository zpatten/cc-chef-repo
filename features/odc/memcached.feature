@odc @memcached
Feature: memcached is running
  In order to ODC
  I need a memcached server

  Background:
    * I ssh to "memcached-certificate-01" with the following credentials:
      | username | keyfile |
      | $lxc$    | $lxc$   |

  Scenario: memcached is installed
    * package "memcached" should be installed

  Scenario: Can connect to memcached server
    When I run "echo stats | nc 192.168.98.10 11211"
    Then I should see "STAT" in the output

  Scenario: Has allocated 768MB of memory memcached server
    When I run "echo stats | nc 192.168.98.10 11211"
    Then I should see "STAT limit_maxbytes 805306368" in the output