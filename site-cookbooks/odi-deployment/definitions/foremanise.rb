define :foremanise, :params => {} do
  template "%s/.foreman" % [
      params[:cwd]
  ] do
    source "dotforeman.erb"
    variables(
        :port => params[:port],
        :app => params[:name],
        :user => params[:user]
    )
  end

  script 'Start Me Up' do
    interpreter 'bash'
    cwd params[:cwd]
    user params[:user]
    code <<-EOF
        export rvmsudo_secure_path=1
        /home/#{params[:user]}/.rvm/bin/rvmsudo bundle exec foreman export upstart /etc/init
    EOF
  end
end