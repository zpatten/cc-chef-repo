name 'memcached'

override_attributes 'chef_client' => {
    'cron'  => {
        'use_cron_d' => true,
        'hour'       => "*",
        'minute'     => "*/5",
        'log_file'   => "/var/log/chef/cron.log"
    },
    "splay" => 250
}


run_list "role[base]",
         "recipe[chef-client::cron]",
         "recipe[odi-memcached]"
