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
  describe 'includes recipes' do
    it { expect_any_instance_of(Chef::Recipe).to receive(:include_recipe).with('apt'); chef_run }
    it { expect_any_instance_of(Chef::Recipe).to receive(:include_recipe).with('git'); chef_run }
    it { expect_any_instance_of(Chef::Recipe).to receive(:include_recipe).with('nodejs'); chef_run }
    it { expect_any_instance_of(Chef::Recipe).to receive(:include_recipe).with('nodejs::npm'); chef_run }
    it { expect_any_instance_of(Chef::Recipe).to receive(:include_recipe).with('mongodb'); chef_run }
    it { expect_any_instance_of(Chef::Recipe).to receive(:include_recipe).with('nginx'); chef_run }
  end

  describe 'calls resources' do
    it { expect(chef_run).to install_nodejs_npm('bower') }
    it { expect(chef_run).to install_nodejs_npm('brunch') }
    it { expect(chef_run).to install_nodejs_npm(api_dir) }
    it { expect(chef_run).to install_nodejs_npm(app_dir) }
    it { expect(chef_run).to run_bash('install bower components and build app') }
    it { expect(chef_run).to create_directory('/usr/share/nginx/www/') }
    it { expect(chef_run).to run_bash("copy_#{api_dir}/dillojs-api.conf_to_/etc/init/") }
    it { expect(chef_run).to run_bash("copy_#{dillo_home}/nginx/etc/nginx.conf_to_/etc/nginx/") }
    it { expect(chef_run).to enable_service('dillojs-api') }
    it { expect(chef_run).to start_service('dillojs-api') }
    it { expect(chef_run).to enable_service('mongodb') }
    it { expect(chef_run).to start_service('mongodb') }
    it { expect(chef_run).to reload_service('nginx') }
  end
end
