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
    "recipe[varnish]",
    "recipe[envbuilder]",
    "recipe[odi-nginx]",
    # it would be loads better if this wasn't required
    "recipe[capybara-webkit]",
    "recipe[quirkafleeg-deployment]"
)