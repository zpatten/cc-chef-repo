name "chef-client"
description "sample chef-client role"
run_list(
  "recipe[chef-client::delete_validation]",
  "recipe[chef-client::config]",
  "recipe[chef-client::cron]"
)

override_attributes(
  :chef_client => {
    :server_url => "https://192.168.33.10",
    :interval => 300,
    :splay => 300,
    :backup_path => "/var/chef/backup",
    :cache_path => "/var/chef/cache",
    :checksum_cache_path => "/var/chef/cache/checksums"
  }
)
