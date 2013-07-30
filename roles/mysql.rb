name "mysql"
description "mysql server role"

run_list(
    "recipe[odi-mysql::server]",
    "recipe[hoppler]"
)