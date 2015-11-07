# encoding: UTF-8

require 'spec_helper'
require 'chefspec'

describe 'dillojs::clean' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '14.04')
      .converge(described_recipe)
  end

  [
    '/opt/dillojs/web/bower_components',
    '/opt/dillojs/web/node_modules',
    '/opt/dillojs/web/public',
    '/opt/dillojs/api/node_modules',
    '/usr/share/nginx/www/'
  ].each do |dir_name|
    it { expect(chef_run).to delete_directory(dir_name) }
  end
end
