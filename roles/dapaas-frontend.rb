name "dapaas-frontend"
description "dapaas frontend wrapper role"

default_attributes(
    :apps => {
        'dapaas-frontend' => {
            :deploy_name        => 'dapaas',
            :port               => 3056,
            :is_default         => true,
            :non_odi_hostname   => 'project.dapaas.eu',
            :catch_and_redirect => 'dapaas.eu'
        }
    }
)

override_attributes(
    :varnish => {
        :listen_port  => 80,
        :backend_host => '127.0.0.1'
    }
)

run_list(
    "role[quirkafleeg]",
    "recipe[varnish]"
)