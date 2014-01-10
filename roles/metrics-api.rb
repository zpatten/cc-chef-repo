name "metrics-api"
description "metrics-api base role"

default_attributes(
    :user              => 'metrics',
    :rvm               => {
        :default_ruby => '1.9.3'
    },
    :project_fqdn      => 'metrics.theodi.org',
    :git_project       => 'metrics-api',
    :chef_client       => {
        :cron  => {
            :use_cron_d => true,
            :hour       => "*",
            :minute     => "*/5",
            :log_file   => "/var/log/chef/cron.log"
        },
        :splay => 250
    },
    :deploy            => {
        :revision => 'master'
    },
    :migration_command => 'bundle exec rake db:migrate',
    :RACK_ENV          => 'production'
)

override_attributes(
    "envbuilder" => {
        "owner" => "env",
        "group" => "env"
    }
)

run_list(
    'role[chef-client]',
    'recipe[odi-apt]',
    'recipe[build-essential]',
    'recipe[postfix]',
    'recipe[git]',
    'recipe[libcurl]',
    'recipe[ntp]',
    'recipe[odi-users]',
    'recipe[odi-pk]',
    'recipe[rvm::system]',
    'recipe[envbuilder]',
    'recipe[mongodb::10gen_repo]',
    'recipe[odi-mongodb]',
    'recipe[mysql::client]',
    'recipe[hoppler::mongo]',
    'recipe[odi-nginx]',
    'recipe[odi-simple-deployment]'
)
