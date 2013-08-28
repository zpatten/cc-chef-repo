name "juvia-webnode"

default_attributes(
    :user              => 'juvia',
    :rvm               => {
        :user => 'juvia',
        :ruby => '1.9.3'
    },
    :project_fqdn      => 'juvia.theodi.org',
    :git_project       => 'juvia',
    :migration_command => 'bundle exec rake db:migrate',
)

override_attributes(
    :deployment => {
        :precompile_assets => true
    }
)

run_list(
    "role[base]",
    "recipe[odi-rvm]",
    "recipe[envbuilder]",
    "recipe[odi-nginx]",
    "recipe[odi-deployment]"
)