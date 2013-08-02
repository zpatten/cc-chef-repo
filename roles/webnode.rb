name "webnode"

default_attributes(
    'user' => 'quirkafleeg',
    'rvm'  => {
        'user' => 'quirkafleeg',
        'ruby' => '1.9.3'
    },
    'aaa'  => 'fdasfdsfdsfdsafdsafdsafas'
)

run_list(
    "recipe[odi-rvm]",
    "recipe[quirkafleeg-deployment]"
)