name "base"
description "sample base role"

run_list(
    "recipe[git]",
    "recipe[postfix]",
    "recipe[ntp]"
)

