@odc @mysql
Feature: mysql is running
  In order to ODC
  I need a mysql server

  Background:
    * I ssh to "mysql-certificate-cucumber" with the following credentials:
      | username | keyfile |
      | $lxc$    | $lxc$   |

  Scenario: MySQL is installed
    * package "mysql-server" should be installed

  Scenario: Can connect to database server
    When I run "mysql -pfakepasswordforcertificate -e 'show databases'"
    Then I should not see "ERROR" in the output

  @restore
  Scenario: Database "certificate" exists
    When I run "mysql -pfakepasswordforcertificate -e 'show databases'"
    Then I should see "certificate" in the output

  @user
  Scenario: hoppler user exists
    When I run "su - hoppler -c 'echo ${SHELL}'"
    Then I should see "/bin/bash" in the output

  @user
  Scenario: hoppler user has ruby 2
    When I run "su - hoppler -c 'ruby -v'"
    Then I should see "2.0.0" in the output

  @code
  Scenario: Hoppler is installed and cronned
    * path "/home/hoppler/hoppler" should exist
    * file "/home/hoppler/hoppler/lib/hoppler.rb" should exist
    * file "/etc/cron.d/hoppler" should contain
    """
0 2 * * * root su - hoppler -c 'cd /home/hoppler/hoppler && `which rake` hoppler:backup'
0 3 * * 7 root su - hoppler -c 'cd /home/hoppler/hoppler && `which rake` hoppler:cleanup'
    """

  @creds
  Scenario: passwords yaml file exists
    * file "/home/hoppler/hoppler/db.creds.yaml" should exist
    When I run "cat /home/hoppler/hoppler/db.creds.yaml"
    Then I should see "^certificate:" in the output

  @envfile
  Scenario: ~/.mysql.env is correct
    * file "/home/hoppler/hoppler/.mysql.env" should be owned by "hoppler:hoppler"
    * file "/home/hoppler/hoppler/.mysql.env" should contain
    """
    MYSQL_USERNAME='root'
    MYSQL_PASSWORD='fakepasswordforcertificate'
    """
    * symlink "/home/hoppler/hoppler/.env" should exist
    When I run "cat /home/hoppler/hoppler/.env"
    Then I should see "RACKSPACE_USERNAME: rax" in the output
    And I should see "RACKSPACE_API_KEY: 567" in the output
    And I should see "RACKSPACE_CONTAINER: dat" in the output
    And I should see "RACKSPACE_DIRECTORY_CONTAINER: theo" in the output
    And I should see "RACKSPACE_DIRECTORY_ASSET_HOST: http://3c15e47727" in the output
    And I should see "RACKSPACE_API_ENDPOINT: lon.auth.api.rackspacecloud.com" in the output

  @chef-client
  Scenario: chef-client is cronned
    When I run "cat /etc/cron.d/chef-client"
    Then I should see "/usr/bin/chef-client &> /var/log/chef/cron.log" in the output