name "sudo"
description "sample sudo role"
run_list(
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
