module ODI
  module Deployment
    module Helpers
      def get_domain
        node[:deployment][:domain]
      end

      def find_a thing
        box_ip = nil
        if Chef::Config[:solo] then
          Chef::Log.warn("This recipe uses search. Chef Solo does not support search.")
        else
          search_string = "name:*%s-%s* AND chef_environment:%s" % [
              thing,
              node[:project],
              node.chef_environment
          ]
          box           = search(:node, search_string)[0]
          box_ip        = box['ipaddress']
          if box['rackspace']
            box_ip = box['rackspace']['private_ip']
          end
        end
        box_ip
      end

      def make_shared_dirs root_dir
        [
            "shared",
            "shared/config",
            "shared/pids",
            "shared/log",
            "shared/system"
        ].each do |d|
          directory "%s/%s" % [
              root_dir,
              d
          ] do
            owner node['user']
            group node['user']
            action :create
            mode "0775"
            recursive true
          end
        end
      end
    end
  end
end