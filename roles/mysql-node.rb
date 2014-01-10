name 'mysql-node'

default_attributes 'user'  => 'hoppler',
                   'group' => 'hoppler',
                   'ruby'  => '2.0.0-p0'

override_attributes "envbuilder"  => {
    "base_dir" => "/home/hoppler/",
    "filename" => ".env",
    "owner"    => "hoppler",
    "group"    => "hoppler"
},
                    'chef_client' => {
                        'cron' => {
                            'use_cron_d' => true,
                            'hour'       => "*",
                            'minute'     => "*/5",
                            'log_file'   => "/var/log/chef/cron.log"
                        }
                    }

run_list "role[base]",
         "recipe[chef-client::cron]",
         "recipe[odi-mysql::server]",
         "recipe[hoppler]"
#         "recipe[envbuilder]"
