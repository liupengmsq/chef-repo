node_instance = search(:node, "hostname:#{node['hostname'].upcase}").first
Chef::Log.info "This is an instance object as returned by Chef Server.EC2 Instance ID is #{node_instance}"

aws_instance = search(:aws_opsworks_instance, "hostname:#{node['hostname'].upcase}").first
Chef::Log.info "This is the AWS OpsWorks instance object. It has AWS OpsWorks specific attributes, like the Layer IDs for the instance: #{aws_instance['layer_ids'].join(',')}"

layer = ""
aws_instance['layer_ids'].each do |layer_id|
  layer = search(:aws_opsworks_layer, "layer_id:#{layer_id}").first
  Chef::Log.info "The instance belongs to layer #{layer['layer_id']}, it's name is #{layer['name']}"
  node.default['layer_name']=layer['name']
end

yum_package "unzip" do
  action :install
end