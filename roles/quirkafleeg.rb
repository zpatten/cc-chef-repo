name "quirkafleeg"
description "quirkafleeg project wrapper role"

default_attributes(
    :project      => 'quirkafleeg',
    :database     => 'signon',
    :databags     => {
        :primary => 'quirkafleeg'
    },
    :govuk        => {
        :app_domain => "theodi.org"
    },
    'chef_client' => {
        'cron'  => {
            'use_cron_d' => true,
            'hour'       => "*",
            'minute'     => "*/5",
            'log_file'   => "/var/log/chef/cron.log"
        },
        'splay' => 250
    }
)

run_list(
    "recipe[odi-apt]",
    "recipe[build-essential]",
    "recipe[git]",
    "role[chef-client]",
    "recipe[postfix]",
    "recipe[ntp]",
    "recipe[odi-users]",
    "recipe[odi-pk]",
    "recipe[mysql::client]",
    "recipe[dictionary]",
    "recipe[nodejs::install_from_package]",
    "recipe[fail2ban]"
)