#
# Cookbook:: node
# Recipe:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.

apt_update 'update_sources' do
  action :update
end

package 'mongodb-org' do
  action [ :update ]
end

service 'mongodb-org' do
  supports status: true, restart: true, reload: true
  action [:enable, :start]
end

template '/etc/mongodb.conf' do
  source 'mongo.conf.erb'
  variables port: node['mongodb']['port'] , ip_addresses: node['mongodb']['ip_addresses']
  notifies :restart, 'service[mongodb]'
end

template '/lib/systemd/system/mongod.service' do
  source 'mongo.service.erb'
  variables port: node['mongodb']['port'] , ip_addresses: node['mongodb']['ip_addresses']
  notifies :restart, 'service[mongodb]'
end

link '/etc/mongodb.conf' do
  to '/lib/systemd/system/mongod.service'
  notifies :restart, 'service[mongodb]'
end

link '/etc/mongodb.conf' do
  notifies :restart, 'service[mongodb]'
  action :delete
end

include_recipe "mongodb"

# nodejs_npm 'pm2'
