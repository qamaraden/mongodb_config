#
# Cookbook:: node
# Recipe:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.

apt_update 'update_sources' do
  action :update
end

package 'mongodb'

service 'mongodb' do
  supports status: true, restart: true, reload: true
  action [:enable, :start]
end

template '/etc/nginx/sites-available/mongo.conf' do
  source 'mongo.conf.erb'
  variables port: node['mongodb']['port'] , ip_addresses: node['mongodb']['ip_addresses']
  notifies :restart, 'service[mongodb]'
end

link '/etc/nginx/sites-enabled/mongo.conf' do
  to '/etc/nginx/sites-available/mongo.conf'
  notifies :restart, 'service[mongodb]'
end

link '/etc/nginx/sites-enabled/default' do
  notifies :restart, 'service[mongodb]'
  action :delete
end

include_recipe "mongodb"

# nodejs_npm 'pm2'
