# encoding: UTF-8

require 'serverspec'

set :backend, :exec

describe 'nginx' do
  describe service 'nginx' do
    it { expect(subject).to be_enabled }
    it { expect(subject).to be_running }
  end

  describe 'mongo' do
    describe service 'mongodb' do
      it { expect(subject).to be_enabled }
      it { expect(subject).to be_running }
    end
  end

  describe package 'nginx' do
    it { expect(subject).to be_installed }
  end

  describe port 80 do
    it { expect(subject).to be_listening }
  end

  describe port 27_017 do
    it { expect(subject).to be_listening }
  end

  describe file '/etc/nginx/nginx.conf' do
    let(:root_location) { 'location / {' }
    let(:api_location) { 'location /api/ {' }

    it { expect(subject).to exist }
    it { expect(subject).to be_file }

    it { expect(subject.content).to include(root_location) }
    it { expect(subject.content).to include(api_location) }
  end
end

describe 'node' do
  describe command 'node -v' do
    it { expect(subject.stdout).to match(/v[0-9]*\.[0-9]*\.[0-9]*/) }
  end
end

describe 'node' do
  describe command 'node -v' do
    it { expect(subject.stdout).to match(/[0-9]*\.[0-9]*\.[0-9]*/) }
  end
end

describe 'app' do
  %w(brunch bower).each do |pkg|
    describe command "npm -g ls | grep #{pkg}" do
      it { expect(subject.exit_status).to eq 0 }
    end
  end
end
