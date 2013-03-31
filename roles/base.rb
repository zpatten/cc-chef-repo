name "base"
description "sample base role"
run_list(
  "recipe[motd-tail]",
  "recipe[timezone]"
  "recipe[users]",
  "recipe[sudo]"
)

default_attributes(
  "authorization" => {
    "groups" => ["devops"],
    "sudo" => {
      "users" => {"deployer" => true},
      "groups" => {"devops" => false}
    }
  }
)
