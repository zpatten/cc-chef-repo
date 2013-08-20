@odc
Feature: cron jobs
  In order to ODC
  I need some cron jobs

  Background:
    * I ssh to "web-odc-01" with the following credentials:
      | username | keyfile |
      | $lxc$    | $lxc$   |

  Scenario: purge_questionnaires job is cronned
    * file "/etc/cron.d/purge_questionnaires" should exist
    And file "/etc/cron.d/purge_questionnaires" should contain
    """
0 2 * * * root su - certificate -c 'cd /var/www/certificates.theodi.org/current && RAILS_ENV=production `which rake` odc:purge_questionnaires'
    """