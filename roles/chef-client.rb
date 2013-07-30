name "chef-client"
description "sample chef-client role"
run_list(
  "recipe[chef-client::delete_validation]",
  "recipe[chef-client::config]",
  "recipe[chef-client::service]"
)

override_attributes(
  :chef_client => {
    :server_url => "https://192.168.33.10",
    :interval => 900,
    :splay => 900,
    :backup_path => "/var/chef/backup",
    :cache_path => "/var/chef/cache",
    :checksum_cache_path => "/var/chef/cache/checksums"
  }
)
