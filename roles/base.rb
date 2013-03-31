name "base"
description "sample base role"
run_list(
  "recipe[bluepill]",
  "recipe[motd-tail]",
  "recipe[timezone]",
  "recipe[users]",
  "recipe[sudo]"
)

override_attributes(
  "authorization" => {
    "groups" => ["devops"],
    "sudo" => {
      "users" => { "deployer" => true },
      "groups" => { "devops" => true }
    }
  }
)
