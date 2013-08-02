name "quirkafleeg"
description "quirkafleeg project wrapper role"

default_attributes(
    :databags => {
        :primary => "quirkafleeg"
    },
    :apps     => {
        'signonotron2' => {
            'deploy_name' => 'signon',
            'port'        => 3000
        }
    },
    :govuk    => {
        :app_domain => "theodi.org"
    }
)