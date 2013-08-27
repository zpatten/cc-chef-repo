name 'git-data-viewer'

default_attributes 'user'              => 'git-data-viewer',
                   'group'             => 'git-data-viewer',
                   'ruby'              => '2.0.0-p0',
                   'project_fqdn'      => 'git-viewer.labs.theodi.org',
                   'git_project'       => 'git-data-viewer',
                   'migration_command' => 'bundle exec rake db:migrate',
                   'chef_client'       => {
                       'cron' => {
                           'use_cron_d' => true,
                           'hour'       => "*",
                           'minute'     => "*/5",
                           'log_file'   => "/var/log/chef/cron.log"
                       }
                   }

override_attributes 'envbuilder'  => {
    'base_dir' => '/var/www/git-viewer.labs.theodi.org/shared/config',
    'owner'    => 'git-data-viewer',
    'group'    => 'git-data-viewer'
},
                    'chef_client' => {
                        'interval' => 300,
                        'splay'    => 30
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
         "recipe[odi-deployment]"