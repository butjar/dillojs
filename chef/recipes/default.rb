# encoding: UTF-8
#
# Cookbook Name:: dillojs
# Recipe:: default

include_recipe 'apt'
include_recipe 'git'
include_recipe 'nodejs'
include_recipe 'nodejs::npm'
include_recipe 'mongodb'
include_recipe 'nginx'

bash 'copy source code' do
  code 'cp -r /srv/dillojs/web /srv/dillojs/api /srv/dillojs/nginx /opt/'
end

%w(bower brunch).each do |pkg|
  nodejs_npm pkg
end

%w(bower_components node_modules public).each do |dir|
  directory "/opt/web/#{dir}" do
    recursive true
    action :delete
  end
end

%w(/opt/web /opt/api).each do |pkg|
  nodejs_npm pkg do
    path pkg
    json true
  end
end

bash 'install bower components and build app' do
  cwd '/opt/web'
  code <<-EOF
    bower install --allow-root
    brunch build --production
  EOF
end

directory '/usr/share/nginx/www/'

{
  '/opt/web/public/*' => '/usr/share/nginx/www/',
  '/opt/api/dillojs-api.conf' => '/etc/init/',
  '/opt/nginx/etc/nginx.conf' => '/etc/nginx/'
}.each do |src, dest|
  bash "copy_#{src}_to_#{dest}" do
    code "cp -r #{src} #{dest}"
  end
end

service 'dillojs-api' do
  action [:enable, :start]
end

service 'mongodb' do
  action [:enable, :start]
end

service 'nginx' do
  action :reload
end
