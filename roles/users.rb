name "users"
description "sample users role"
run_list(
  "recipe[users]"
)

default_attributes(
  "authorization" => {
    "groups" => ["devops"]
  }
)
