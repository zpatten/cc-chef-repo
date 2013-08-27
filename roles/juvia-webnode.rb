name "juvia"

default_attributes(
    :users              => [
        'juvia',
        'quirkafleeg'
    ],
    'envbuilder'  => {
        'base_dir' => '/home/quirkafleeg',
        'owner' => 'quirkafleeg',
        'group' => 'quirkafleeg'
    },
    :rvm               => {
        :user => 'juvia',
        :ruby => '1.9.3'
    },
    :project_fqdn      => 'juvia.theodi.org',
    :mysql_db          => 'juvia',
    :memcached_node    => 'juvia',
    :git_project       => 'juvia',
    :migration_command => 'bundle exec rake db:migrate',
)

run_list "role[base]",
         "recipe[odi-rvm]",
         "recipe[envbuilder]",
         "recipe[odi-deployment]"