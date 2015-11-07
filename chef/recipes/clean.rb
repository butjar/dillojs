# encoding: UTF-8
#
# Cookbook Name:: dillojs
# Recipe:: clean

[
  "#{node['dillojs']['web']['home']}/bower_components",
  "#{node['dillojs']['web']['home']}/node_modules",
  "#{node['dillojs']['web']['home']}/public",
  "#{node['dillojs']['api']['home']}/node_modules",
  node['dillojs']['nginx']['root_dir']
].each do |dir|
  directory dir do
    recursive true
    action :delete
  end
end
