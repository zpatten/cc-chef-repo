name "mongodb"
description "mongodb server role"

default_attributes(
    'user'    => 'hoppler',
    'hoppler' => {
        'backup_command' => 'backup_mongo',
        'do_restore'     => false
    }
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
    "recipe[mongodb::10gen_repo]",
    "recipe[odi-mongodb]",
    "recipe[hoppler]"
)