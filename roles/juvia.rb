name "juvia"

default_attributes(
    :databags   => {
        :primary => 'juvia'
    },
    :user       => 'juvia',
    :envbuilder => {
        :base_dir => '/home/juvia',
        :owner    => 'juvia',
        :group    => 'juvia'
    },
    :database   => 'juvia',
    'chef_client'       => {
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
    "recipe[git]",
    "recipe[build-essential]",
    "recipe[git]",
    "recipe[postfix]",
    "recipe[ntp]",
    "recipe[odi-users]",
    "recipe[odi-xml]",
    "recipe[xslt]",
    "recipe[mysql::client]",
    "recipe[dictionary]",
    "recipe[nodejs::install_from_package]",
    "role[chef-client]",
    "recipe[odi-pk]",
    "recipe[fail2ban]"
)