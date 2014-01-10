name 'csvlint'
description 'csvlint'

default_attributes(
    :databags    => {
        :primary => 'csvlint'
    },
    :chef_client => {
        :cron => {
            :use_cron_d => true,
            :hour       => '*',
            :minute     => '*/5',
            :log_file   => '/var/log/chef/cron.log'
        }
    }
)