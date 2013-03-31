name "chef-client"
description "sample chef-client role"
run_list(
  "recipe[chef-client::delete_validation]",
  "recipe[chef-client::config]",
  "recipe[chef-client::service]"
)

override_attributes(
  :chef_client => {
    :interval => 900,
    :splay => 900,
    :init_style => "bluepill",
    :backup_path => "/var/chef/backup",
    :cache_path => "/var/chef/cache",
    :checksum_cache_path => "/var/chef/cache/checksums"
  }
)
