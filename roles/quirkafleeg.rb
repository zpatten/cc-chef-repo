name "quirkafleeg"
description "quirkafleeg project wrapper role"

default_attributes(
    :project => 'quirkafleeg',
    :databags => {
        :primary => 'quirkafleeg'
    },
    :apps     => {
        'signonotron2' => {
            :deploy_name => 'signon',
            :port        => 3000
        },
        'static'       => {
            :port        => 4000
        },
        'panopticon'   => {
            :port => 5000
        },
        'publisher' => {
            :port => 6000,
            # not sure about this
            :mongo_db => 'govuk_content_publisher'
        }
    },
    :govuk    => {
        :app_domain => "theodi.org"
    }
)