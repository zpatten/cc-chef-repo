name "mongodb"
description "mongodb server role"

run_list(
    "recipe[mongodb::10gen_repo]",
    "recipe[mongodb]"
)