name "webnode"

default_attributes(
    'user' => 'quirkafleeg',
    'rvm'  => {
        'user' => 'quirkafleeg',
        'ruby' => '1.9.3'
    },
    'envbuilder'  => {
        'base_dir' => '/home/quirkafleeg',
        'owner' => 'quirkafleeg',
        'group' => 'quirkafleeg'
    }
)

run_list(
    "recipe[odi-rvm]",
    "recipe[envbuilder]",
    "recipe[quirkafleeg-deployment]"
)