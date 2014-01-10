name 'simple-mysql'

run_list 'role[base]',
         'recipe[chef-client::cron]',
         'recipe[odi-mysql::server]'