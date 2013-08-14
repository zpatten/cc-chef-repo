actions :create
default_action :create

attribute :deploy_name, :kind_of => String, :name_attribute => true
attribute :cwd, :kind_of => String
attribute :port, :kind_of => Integer
attribute :user, :kind_of => String