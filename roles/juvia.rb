name "juvia"

default_attributes(
    :databags    => {
        :primary => 'juvia'
    },
    :users       => [
        'juvia'
    ],
    'envbuilder' => {
        'base_dir' => '/home/juvia',
        'owner'    => 'juvia',
        'group'    => 'quirkafleeg'
    },
    :database   => 'juvia'
)

run_list(
    "role[base]",
    "role[chef-client]"
)