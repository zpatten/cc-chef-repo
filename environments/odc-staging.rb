name 'odc-staging'

default_attributes 'ENV'          => 'staging',
                   'RACK_ENV'     => 'production',
                   'logstash_env' => 'production',
                   'chef_client'  => {
                       'server_url' => 'https://chef.theodi.org'
                   },
                   'deploy'       => {
                       'revision' => 'STAGING'
                   },
                   'nginx' => {
                       'vhost_prefix' => 'staging'
                   }

override_attributes 'nginx'       => {
                        'force_ssl' => false,
                        '301_redirects' => nil
                    }

cookbook 'envbuilder', '= 0.1.5'
cookbook 'imagemagick', '= 0.2.2'
cookbook 'libcurl', '= 0.1.0'
cookbook 'odi-nginx', '= 0.1.4'
cookbook 'odi-rvm', '= 0.1.1'
cookbook 'odi-users', '= 0.1.0'
cookbook 'odi-xml', '= 0.1.0'
cookbook 'odi-memcached', '= 0.1.0'
cookbook 'redisio', '= 1.4.1'
cookbook 'rvm', '= 0.0.2'
cookbook 'sqlite', '= 0.1.0'
cookbook 'xslt', '= 0.0.1'
cookbook 'hoppler', '= 0.1.2'
cookbook 'apt', '= 1.9.0'
cookbook 'odi-deployment', '= 0.2.2'
cookbook 'odi-mysql', '= 0.2.0'
