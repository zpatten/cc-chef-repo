name "quirkafleeg-frontend"
description "quirkafleeg frontend wrapper role"

default_attributes(
    :apps => {
        },
        #        'people'           => {
        #            :port    => 3000
        #        },
        #        'frontend-news'    => {
        #            :deploy_name => 'news',
        #            :port        => 3010
        #        },
        #        'frontend-courses' => {
        #            :deploy_name => 'courses',
        #            :port        => 3030
        #        },
    }
)

run_list(
    "role[quirkafleeg]"
)