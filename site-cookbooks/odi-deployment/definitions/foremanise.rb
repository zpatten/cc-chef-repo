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
        RUBY="#{node[:rvm][:user_installs].select { |h| h[:user] == user }[0][:default_ruby]}"
        BINPATH="/home/#{user}/.rvm/bin/:/home/#{user}/.rvm/rubies/ruby-${RUBY}/bin/"
        PATH=${BINPATH}:${PATH}
        export rvmsudo_secure_path=1
        rvmsudo bundle exec foreman export upstart /etc/init
    EOF
  end
end