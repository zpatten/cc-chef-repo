name "quirkafleeg"
description "quirkafleeg project wrapper role"

default_attributes(
    :databags => {
        :primary => "quirkafleeg"
    },
    :apps     => {
        'signonotron2' => 'signon'
    }
)