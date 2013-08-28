@juvia @mysql
Feature: mysql server role
  In order to run Juvia
  I want a mysql server

  Background:
    * I ssh to "mysql-juvia-cucumber" with the following credentials:
      | username | keyfile |
      | $lxc$    | $lxc$   |

  Scenario: Chef-Client is running as a daemon
    When I run "ps aux | grep [c]hef-client"
    Then the exit code should be "0"
    And I should see "chef-client" in the output
    And I should see "-i 300" in the output
    And I should see "-s 300" in the output

  Scenario: The Chef-Server validation key has been removed
    When I run "[[ ! -e /etc/chef/validation.pem ]]"
    Then the exit code should be "0"

  Scenario: postfix is installed
    * package "postfix" should be installed

  Scenario: ntp is installed
    When I run "ps ax | grep 'ntpd ' | grep -v grep"
    Then the exit code should be "0"

  Scenario: MySQL is installed
    * package "mysql-server" should be installed

  Scenario: Can connect to database server
    When I run "mysql -p'passwordbeallfakeforjuvia' -e 'show databases'"
    Then I should not see "ERROR" in the output

  Scenario: Database "juvia" exists
    When I run "mysql -p'passwordbeallfakeforjuvia' -e 'show databases'"
    Then I should see "juvia" in the output

  Scenario: hoppler user exists
    When I run "su - hoppler -c 'echo ${SHELL}'"
    Then I should see "/bin/bash" in the output

  Scenario: hoppler user has ruby 2
    When I run "su - hoppler -c 'ruby -v'"
    Then I should see "2.0.0" in the output

  Scenario: Hoppler is installed and cronned
    * path "/home/hoppler/hoppler" should exist
    And file "/home/hoppler/hoppler/lib/hoppler.rb" should exist
    And file "/etc/cron.d/hoppler" should contain
    """
0 2 * * * root su - hoppler -c 'cd /home/hoppler/hoppler && `which rake` hoppler:backup'
0 3 * * 7 root su - hoppler -c 'cd /home/hoppler/hoppler && `which rake` hoppler:cleanup'
    """

  Scenario: passwords yaml file exists
    * file "/home/hoppler/hoppler/db.creds.yaml" should exist
    When I run "cat /home/hoppler/hoppler/db.creds.yaml"
    Then I should see "^juvia:" in the output

  Scenario: ~/.mysql.env is correct
    * file "/home/hoppler/hoppler/.mysql.env" should be owned by "hoppler:hoppler"
    And file "/home/hoppler/hoppler/.mysql.env" should contain
    """
    MYSQL_USERNAME='root'
    MYSQL_PASSWORD='passwordbeallfakeforjuvia'
    """
    And symlink "/home/hoppler/hoppler/.env" should exist
    When I run "cat /home/hoppler/hoppler/.env"
    Then I should see "RACKSPACE_USERNAME: rax" in the output
    And I should see "RACKSPACE_API_KEY: 567" in the output
    And I should see "RACKSPACE_CONTAINER: dat" in the output
    And I should see "RACKSPACE_DIRECTORY_CONTAINER: theo" in the output
    And I should see "RACKSPACE_API_ENDPOINT: lon.auth.api.rackspacecloud.com" in the output
    And I should see "RACKSPACE_DIRECTORY_ASSET_HOST: http://3c15e47727" in the output