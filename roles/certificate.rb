name 'certificate'

default_attributes 'user'              => 'certificate',
                   'group'             => 'certificate',
                   'ruby'              => '1.9.3-p392',
                   'project_fqdn'      => 'certificates.theodi.org',
                   'mysql_db'          => 'certificate',
                   'memcached_node'    => 'certificate',
                   'git_project'       => 'open-data-certificate',
                   'migration_command' => 'bundle exec rake db:migrate',
                   'after_restart_commands' => [
                       'bundle exec rake surveyor:enqueue_surveys',
                       'bundle exec rake cache:clear'
                   ],
                   'nginx'             => {
                       'force_ssl'     => true,
                       '301_redirects' => [
                           'certificate.theodi.org'
                       ]
                   },
                   'chef_client'       => {
                       'cron'  => {
                           'use_cron_d' => true,
                           'hour'       => "*",
                           'minute'     => "*/5",
                           'log_file'   => "/var/log/chef/cron.log"
                       },
                       'splay' => 250

                   },
                   'require_memcached' => true

override_attributes 'envbuilder' => {
    'base_dir' => '/var/www/certificates.theodi.org/shared/config',
    'owner'    => 'certificate',
    'group'    => 'certificate'
}

run_list "role[base]",
         "recipe[chef-client::cron]",
         "recipe[build-essential]",
         "recipe[nginx]",
         "recipe[odi-users]",
         "recipe[odi-rvm]",
         "recipe[odi-xml]",
         "recipe[odi-nginx]",
         "recipe[xslt]",
         "recipe[libcurl]",
         "recipe[nodejs::install_from_package]",
         "recipe[mysql::client]",
         "recipe[sqlite::dev]",
         "recipe[envbuilder]",
         "recipe[odi-deployment]",
         "recipe[odi-logstash::agent]"