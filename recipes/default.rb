#
# Cookbook:: node
# Recipe:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.

apt_update 'update' do
  action :update
end

apt_repository 'mongodb-org' do
  uri "http://repo.mongodb.org/apt/ubuntu"
  distribution 'xenial/mongodb-org/3.2'
  components ['multiverse']
  keyserver 'hkp://keyserver.ubuntu.com:80'
  key 'EA312927'
end

package 'mongodb-org' do
  action [:upgrade, :install]
end


template '/lib/systemd/system/mongod.service' do
  source 'mongod.service.erb'
  variables proxy_port: 27017
  owner "mongodb"
  group "mongodb"
  mode 00644  # -rw-r--r--

  notifies :restart, 'service[mongod]'
end

template '/etc/mongod.conf' do
  source 'mongod.conf.erb'
  owner "mongodb"
  group "mongodb"
  mode 00644 # -rw-r--r--
  variables proxy_port: 27017

  notifies :restart, 'service[mongod]'
end



service 'mongod' do
  supports status: true, restart: true, reload: true
  action [:enable, :start]
end


# nodejs_npm 'pm2'
