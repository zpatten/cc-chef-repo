name "metrics-api"
description "metrics-api base role"

default_attributes(
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
    "recipe[fail2ban]"
)
