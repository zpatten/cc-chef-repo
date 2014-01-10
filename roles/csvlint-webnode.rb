name 'csvlint-webnode'

default_attributes(
    :user              => 'csvlint',
    :rvm               => {
        :user_installs => [
            {
                :user         => 'csvlint',
                :rubies       => [
                    '2.1.0'
                ],
                :default_ruby => '2.1.0'
            }
        ]
    },
    :project_fqdn      => 'csvlint.io',
    :git_project       => 'csvlint',
    :deployment        => {
        :revision          => 'master',
        :precompile_assets => true
    },
    :has_db            => true,
    :database          => 'csvlint',
    :non_odi_hostname  => 'csvlint.io',
    :catch_and_redirect => 'www.csvlint.io',
    :envbuilder        => {
        :base_dir => '/home/csvlint',
        :owner    => 'csvlint',
        :group    => 'csvlint'
    },
    :migration_command => 'bundle exec rake db:migrate'
)

override_attributes(
    :nginx => {
        :listen_port => 80
    }
)

run_list(
    'role[chef-client]',
    'recipe[odi-apt]',
    'recipe[build-essential]',
    'recipe[odi-users]',
    'recipe[mysql::client]',
    'recipe[rvm::user]',
    'recipe[nginx]',
    'recipe[envbuilder]',
    'recipe[odi-deployment]'
)