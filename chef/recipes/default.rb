# encoding: UTF-8
#
# Cookbook Name:: dillojs
# Recipe:: default

%w(apt git nodejs nodejs::npm mongodb nginx).each do |recipe|
  include_recipe recipe
end

node['dillojs']['npm']['packages']['global'].each do |pkg|
  nodejs_npm pkg
end

%w(bower_components node_modules public).each do |dir|
  directory "#{node['dillojs']['web']['home']}/#{dir}" do
    recursive true
    action :delete
  end
end

[ node['dillojs']['api']['home'], node['dillojs']['web']['home'] ].each do |pkg|
  nodejs_npm pkg do
    path pkg
    json true
  end
end

directory node['dillojs']['nginx']['root_dir']

bash 'install bower components and build app' do
  cwd node['dillojs']['web']['home']
  code <<-EOF
    bower install --allow-root
    brunch build --production --env production
  EOF
end

{
  "#{node['dillojs']['api']['home']}/dillojs-api.conf" => '/etc/init/',
  "#{node['dillojs']['home']}/nginx/etc/nginx.conf" => '/etc/nginx/'
}.each do |src, dest|
  bash "copy_#{src}_to_#{dest}" do
    code "cp -r #{src} #{dest}"
  end
end

%w(dillojs-api mongodb).each do |s|
  service s do
    action [:enable, :start]
  end
end

service 'nginx' do
  action :reload
end
