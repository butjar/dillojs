# encoding: UTF-8

require 'serverspec'
require 'net/ssh'

# Require shared examples
# https://github.com/rubyisbeautiful/serverspec_examples/blob/master/spec/spec_helper.rb
spec_dir = Pathname.new(File.join(File.dirname(__FILE__)))
Dir[spec_dir.join('shared/**/*.rb')].sort.each { |f| require f }

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

def ssh?
  ENV['DRIVER'].eql? 'vagrant'
end

options = Net::SSH::Config.for(host) if ssh?

case ENV['DRIVER']
when 'vagrant'
  set :backend, :ssh
  options[:user] = 'vagrant'
  options[:password] = 'vagrant'
  options[:port] = 2222
  options[:host_name] = '127.0.0.1'
when 'docker'
  require 'docker'
  set :backend, :docker
end

if ssh?
  set :host,        options[:host_name]
  set :ssh_options, options
end
