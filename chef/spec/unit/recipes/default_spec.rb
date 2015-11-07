require 'spec_helper'
require 'chefspec'

describe 'dillojs::default' do
  before do
    allow_any_instance_of(Chef::Recipe).to receive(:include_recipe).and_call_original
    %w(apt git nodejs nodejs::npm mongodb nginx).each do |recipe|
      allow_any_instance_of(Chef::Recipe).to receive(:include_recipe).with(recipe)
    end
  end

  let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '14.04').converge(described_recipe) }
  let(:dillo_home) { '/opt/dillojs' }
  let(:api_dir) { "#{dillo_home}/api" }
  let(:app_dir) { "#{dillo_home}/web" }

  # https://github.com/sethvargo/chefspec#include_recipe
  # https://github.com/sethvargo/chefspec/issues/569
  describe 'recipes' do
    %w(apt git nodejs nodejs::npm mongodb nginx dillojs::clean).each do |recipe|
      it 'includes apt' do
        expect_any_instance_of(Chef::Recipe)
          .to receive(:include_recipe).with(recipe)
        chef_run
      end
    end
  end

  describe 'calls resources' do
    it { expect(chef_run).to run_bash('install bower components and build app') }
    %w(bower brunch).each do |pkg|
      it { expect(chef_run).to install_nodejs_npm(pkg) }
    end

    %w(/opt/dillojs/api /opt/dillojs/web).each do |dir|
      it { expect(chef_run).to install_nodejs_npm(dir) }
    end

    it { expect(chef_run).to create_directory('/usr/share/nginx/www/') }

    [
      'copy_/opt/dillojs/api/dillojs-api.conf_to_/etc/init/',
      'copy_/opt/dillojs/nginx/etc/nginx.conf_to_/etc/nginx/'
    ].each do |command|
      it { expect(chef_run).to run_bash(command) }
    end
    it { expect(chef_run).to enable_service('dillojs-api') }
    it { expect(chef_run).to start_service('dillojs-api') }
    it { expect(chef_run).to enable_service('mongodb') }
    it { expect(chef_run).to start_service('mongodb') }
    it { expect(chef_run).to reload_service('nginx') }
  end
end
