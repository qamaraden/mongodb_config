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

template '/etc/nginx/sites-available/mongo_proxy.conf' do
  source 'proxy.conf.erb'
  variables proxy_port: node['nginx']['mongo_proxy_port']
  notifies :restart, 'service[nginx]'
end

link '/etc/nginx/sites-enabled/mongo_proxy.conf' do
  to '/etc/nginx/sites-available/mongo_proxy.conf'
  notifies :restart, 'service[mongodb]'
end

link '/etc/nginx/sites-enabled/default' do
  notifies :restart, 'service[mongodb]'
  action :delete
end

include_recipe "mongodb"

# nodejs_npm 'pm2'
