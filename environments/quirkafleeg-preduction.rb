name "quirkafleeg-preduction"
description "quirkafleeg-preduction"

default_attributes(
    'ENV' => "production",
    'deployment' => {
        'revision' => 'master'
    }
)
