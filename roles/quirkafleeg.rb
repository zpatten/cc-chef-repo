name "quirkafleeg"
description "quirkafleeg project wrapper role"

default_attributes(
    :project      => 'quirkafleeg',
    :database     => 'signon',
    :databags     => {
        :primary => 'quirkafleeg'
    },
    :apps         => {
        'signonotron2'     => {
            :deploy_name => 'signon',
            :port        => 3000,
            :mysql_db    => 'signon',
            :migrate     => 'bundle exec rake db:migrate'
        },
        'static'           => {
            :port        => 4000,
            :assets_path => 'static'
        },
        'panopticon'       => {
            :port     => 5000,
            :mongo_db => 'govuk_content_publisher'
        },
        'publisher'        => {
            :port     => 6000,
            :mongo_db => 'govuk_content_publisher'
        },
        'content_api'      => {
            :deploy_name       => 'contentapi',
            :port              => 7000,
            :precompile_assets => false,
            :mongo_db          => 'govuk_content_publisher'
        },
        'people'           => {
            :port => 8000
        },
        'frontend-news'    => {
            :deploy_name => 'news',
            :port        => 10000
        },
        'frontend-www'     => {
            :deploy_name => 'www',
            :port        => 11000
        },
        'frontend-courses' => {
            :deploy_name => 'courses',
            :port        => 12000
        },
        'asset-manager'    => {
            :port              => 13000,
            :mongo_db          => 'govuk_content_publisher',
            :precompile_assets => false
        },
    },
    :govuk        => {
        :app_domain => "theodi.org"
    },
    'chef_client' => {
        'cron'  => {
            'use_cron_d' => true,
            'hour'       => "*",
            'minute'     => "*/5",
            'log_file'   => "/var/log/chef/cron.log"
        },
        'splay' => 250
    }
)

override_attributes(
    :varnish => {
        :listen_port  => 80,
        :backend_host => '127.0.0.1'
    }
)

run_list(
    "recipe[odi-apt]",
    "recipe[build-essential]",
    "recipe[git]",
    "role[chef-client]",
    "recipe[postfix]",
    "recipe[ntp]",
    "recipe[odi-users]",
    "recipe[odi-pk]",
    "recipe[mysql::client]",
    "recipe[dictionary]",
    "recipe[nodejs::install_from_package]",
    "recipe[fail2ban]"
)