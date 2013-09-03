name "chef-client"
description "sample chef-client role"
run_list(
    "recipe[chef-client::delete_validation]",
    "recipe[chef-client::config]",
    "recipe[chef-client::cron]"
)

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

override_attributes(
    :chef_client => {
        :server_url          => "https://192.168.33.10",
        :interval            => 300,
        :splay               => 300,
        :backup_path         => "/var/chef/backup",
        :cache_path          => "/var/chef/cache",
        :checksum_cache_path => "/var/chef/cache/checksums"
    }
)
