name "base"
description "sample base role"

run_list(
    "recipe[build-essential]",
    "recipe[git]",
    "recipe[postfix]",
    "recipe[ntp]",
    "recipe[odi-users]",
    "recipe[odi-xml]",
    "recipe[xslt]",
    "recipe[mysql::client]",
    "recipe[dictionary]",
    "recipe[nodejs::install_from_package]"
)

