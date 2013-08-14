action :create do
#  script 'Start Me Up' do
#    interpreter 'bash'
#    cwd @new_resource.cwd
#    user @new_resource.user
#    code <<-EOF
#        export rvmsudo_secure_path=1
#        /home/#{@new_resource.user}/.rvm/bin/rvmsudo bundle exec foreman export \
#          -a #{@new_resource.deploy_name} \
#          -u #{@new_resource.user} \
#          -l /var/log/#{@new_resource.user}/#{@new_resource.deploy_name} \
#          -p #{@new_resource.port} \
#          upstart /etc/init
#    EOF
#  end
end