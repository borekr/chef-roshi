#
# Cookbook Name:: roshi
# Recipe:: default
#
# Copyright 2016, Rob Borek
#
# All rights reserved - Do Not Redistribute
#

redisio_install "redis-installation" do
  version '3.2.4'
  download_url 'http://download.redis.io/releases/redis-3.2.4.tar.gz'
  install_dir '/usr/local'
end

redisio_configure "redis-install" do
  version '3.2.4'
  default_settings node['redisio']['default_settings']
  servers node['redisio']['servers']
  base_piddir node['redisio']['base_piddir']
  user 'redis'
  group 'redis'
end

service 'redismaster' do
  action [:enable, :start]
end


package 'nginx' do
  action :install
end

cookbook_file "/etc/nginx/nginx.conf" do
  source "nginx.conf"
  mode "0644"
end

service 'nginx' do
  action [:enable, :start]
end



