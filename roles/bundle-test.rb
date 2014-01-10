name 'bundle-test'

default_attributes(
    :user         => 'bundletest',
    :rvm          => {
        :user_installs => [
            {
                :user         => 'bundletest',
                :rubies       => [
                    '2.1.0'
                ],
                :default_ruby => '2.1.0'
            }
        ]
    },
    :project_fqdn => 'csvlint.io',
    :git_project  => 'csvlint',
    :deployment   => {
        :revision          => 'master',
        :precompile_assets => false
    },
    :has_db       => false,
    :non_odi_hostname => 'csvlint.io'
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
    'recipe[rvm::user]',
    'recipe[nginx]',
    'recipe[odi-deployment]'
)