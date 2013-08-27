name 'odc-production'

default_attributes 'ENV'          => 'production',
                   'RACK_ENV'     => 'production',
                   'logstash_env' => 'production',
                   'chef_client'  => {
                       'server_url' => 'https://chef.theodi.org'
                   },
                   'deploy'       => {
                       'revision' => 'CURRENT'
                   }

cookbook 'envbuilder', '= 0.2.0'
cookbook 'imagemagick', '= 0.2.2'
cookbook 'libcurl', '= 0.1.0'
cookbook 'odi-nginx', '= 0.1.3'
cookbook 'odi-rvm', '= 0.2.0'
cookbook 'odi-users', '= 0.2.0'
cookbook 'odi-xml', '= 0.1.0'
cookbook 'odi-memcached', '= 0.1.0'
cookbook 'redisio', '= 1.4.1'
cookbook 'rvm', '= 0.0.2'
cookbook 'sqlite', '= 0.1.0'
cookbook 'xslt', '= 0.0.1'
cookbook 'hoppler', '= 0.2.0'
cookbook 'apt', '= 1.9.0'
cookbook 'odi-deployment', '= 0.2.1'
cookbook 'odi-mysql', '= 0.3.0'
