name "mongodb"
description "mongodb server role"

default_attributes(
    # THESE TWO ARE REQUIRED TO MAKE HOPPLER COOKBOOK WORK. THIS IS TECHNICAL DEBT. I'VE ALSO HAD TO ADD A
    # MONGO_HOST ENV VAR. THIS IS VERY POOR. RECYCLING HOPPLER WAS A MISTAKE, I WILL FORK IT INSTEAD.
    :databags     => {
        :primary => 'quirkafleeg'
    },
    :database     => 'signon',
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
    "recipe[mysql::client]",
    "recipe[mongodb::10gen_repo]",
    "recipe[odi-mongodb]",
    "recipe[hoppler]"
)