@quirkafleeg @logstash
Feature: logstash server role
  In order to run Quirkafleeg
  I want a logstash server

  Background:
    * I ssh to "logstash-quirkafleeg" with the following credentials:
      | username | keyfile |
      | $lxc$    | $lxc$   |

  Scenario: The Chef-Server validation key has been removed
    When I run "[[ ! -e /etc/chef/validation.pem ]]"
    Then the exit code should be "0"

  Scenario: postfix is installed
    * package "postfix" should be installed

  Scenario: git is installed
    * package "git" should be installed

  Scenario: odi user exists
    When I run "su - odi -c 'echo ${SHELL}'"
    Then I should see "/bin/bash" in the output

  Scenario: ntp is installed
    When I run "ps ax | grep 'ntpd ' | grep -v grep"
    Then the exit code should be "0"

  Scenario: java is installed
    When I run "java -version"
    Then I should not see "command not found" in the output

  Scenario: elasticsearch is running
    When I run "jps"
    Then I should see "ElasticSearch" in the output

  @config
  Scenario: custom config has been applied
    When I run "cat /usr/local/etc/elasticsearch/elasticsearch.yml"
    Then I should not see "network.host: 192.168.99.50" in the output
    And I should see "cluster.name: logstash" in the output
    And I should see "bootstrap.mlockall: false" in the output

  @chef-client
  Scenario: chef-client is cronned
    When I run "cat /etc/cron.d/chef-client"
    Then I should see "/usr/bin/chef-client &> /var/log/chef/cron.log" in the output