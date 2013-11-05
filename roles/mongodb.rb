name "mongodb"
description "mongodb server role"

default_attributes(
    'user'    => 'hoppler'
)

override_attributes(
    "envbuilder" => {
        "base_dir" => "/home/hoppler/",
        "filename" => ".env",
        "owner"    => "hoppler",
        "group"    => "hoppler"
    }
)

run_list(
    "recipe[mysql::client]",
    "recipe[mongodb::10gen_repo]",
    "recipe[odi-mongodb]",
    "recipe[hoppler::mongo]"
)