define :foremanise, :params => {} do
  script 'Start Me Up' do
    interpreter 'bash'
    cwd params[:cwd]
    user params[:user]
    code <<-EOF
        export rvmsudo_secure_path=1
        /home/#{params[:user]}/.rvm/bin/rvmsudo bundle exec foreman export \
          -a #{params[:name]} \
          -u #{params[:user]} \
          -l /var/log/#{params[:user]}/#{params[:name]} \
          -p #{params[:port]} \
          upstart /etc/init
    EOF
  end
end