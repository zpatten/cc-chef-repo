name 'elasticsearch-server'

default_attributes 'elasticsearch' => {
    'cluster_name'       => 'logstash',
    'bootstrap_mlockall' => false
}

override_attributes 'chef_client' => {
    'cron'  => {
        'use_cron_d' => true,
        'hour'       => "*",
        'minute'     => "*/5",
        'log_file'   => "/var/log/chef/cron.log"
    },
    'splay' => 250
}

run_list "role[quirkafleeg]",
         "recipe[java]",
         "recipe[odi-elasticsearch]"
