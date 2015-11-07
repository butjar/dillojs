# encoding: UTF-8
#
# Cookbook Name:: dillojs
# Recipe:: default

%w(apt git nodejs nodejs::npm mongodb nginx dillojs::clean).each do |recipe|
  include_recipe recipe
end

node['dillojs']['npm']['packages']['global'].each do |pkg|
  nodejs_npm pkg
end

[node['dillojs']['api']['home'], node['dillojs']['web']['home']].each do |pkg|
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

bash 'set api to localhost in hosts' do
  code "sudo sed -i '/^127.0.0.1/ s/$/ api/' /etc/hosts"
end

%w(dillojs-api mongodb).each do |s|
  service s do
    action [:enable, :start]
  end
end

service 'nginx' do
  action :reload
end
