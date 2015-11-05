# encoding: UTF-8

require 'serverspec'
require 'net/ssh'

if ENV['ASK_SUDO_PASSWORD']
  begin
    require 'highline/import'
  rescue LoadError
    raise 'highline is not available. Try installing it.'
  end
  set :sudo_password, ask('Enter sudo password: ') { |q| q.echo = false }
else
  set :sudo_password, ENV['SUDO_PASSWORD']
end

options = Net::SSH::Config.for(host)

case ENV['DRIVER']
when 'vagrant'
  set :backend, :ssh
  options[:user] = 'vagrant'
  options[:password] = 'vagrant'
  options[:port] = 2222
  options[:host_name] = '127.0.0.1'
when 'docker'
  #   host = ENV['DOCKER_HOST'].match(/tcp:\/\/(.*):.*/)[1]
  set :backend, :docker
end

set :host,        options[:host_name]
set :ssh_options, options
