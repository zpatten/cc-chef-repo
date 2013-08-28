name "juvia"

default_attributes(
    :databags   => {
        :primary => 'juvia'
    },
    :user       => 'juvia',
    :envbuilder => {
        :base_dir => '/home/juvia',
        :owner    => 'juvia',
        :group    => 'juvia'
    },
    :database   => 'juvia'
)

run_list(
    "role[base]",
    "role[chef-client]"
)