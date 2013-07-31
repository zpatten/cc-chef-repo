name "mysql"
description "mysql server role"

run_list(
    "recipe[odi-mysql::server]",
    "recipe[hoppler]"
)

default_attributes(
    'user' => 'hoppler'
)

override_attributes(
    "envbuilder" => {
        "base_dir" => "/home/hoppler/",
        "filename" => ".env",
        "owner"    => "hoppler",
        "group"    => "hoppler"
    }
)