provider        :vagrant
librarian_chef  true
prerelease      true

artifacts       ({ "chef-client-log" => "/var/log/chef/client.log",
                   "chef-client-stacktrace" => "/var/chef/cache/chef-stacktrace.out" })

vagrant.merge!( :identity_file => "#{ENV['HOME']}/.vagrant.d/insecure_private_key",
                :lab_user => "vagrant",
                :lxc_user => "root",
                :ssh => {
                    :lab_ip => "192.168.33.10",
                    :lab_port => 22,
                    :lxc_port => 22
                },
                :cpus => 4,
                :memory => 4096 )

aws.merge!(     :identity_file => ENV['AWS_IDENTITY'],
                :lab_user => "ubuntu",
                :lxc_user => "root",
                :ssh => {
                    :lab_port => 22,
                    :lxc_port => 22
                },
                :aws_access_key_id => ENV['AWS_ACCESS_KEY_ID'],
                :aws_secret_access_key => ENV['AWS_SECRET_ACCESS_KEY'],
                :aws_ssh_key_id => ENV['AWS_SSH_KEY_ID'],
                :region => "us-west-2",
                :availability_zone => "us-west-2a",
                :aws_instance_arch => "i386",
                :aws_instance_type => "c1.medium" )

chef.merge!(    :version => "10.24.0")
# chef.merge!(    :version => "11.4.0")
# chef.merge!(    :version => "latest")
