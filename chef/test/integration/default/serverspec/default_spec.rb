require 'serverspec'

# Required by serverspec
set :backend, :exec

describe 'nginx' do
  describe package 'nginx' do
    it { expect(subject).to be_installed }
  end

  describe service 'nginx' do
    it { expect(subject).to be_enabled }
    it { expect(subject).to be_running }
  end

  describe port(80) do
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

describe 'mongo' do
  describe package 'mongodb' do
    it { expect(subject).to be_installed }
  end

  describe service 'mongodb' do
    it { expect(subject).to be_enabled }
    it { expect(subject).to be_running }
  end

  describe port(27017) do
    it { expect(subject).to be_listening }
  end

  describe 'nodejs' do
    describe command 'node -v' do
      it { expect(subject.stdout).to match /v[0-9]*\.[0-9]*\.[0-9]*/ }
    end

    describe command 'npm -v' do
      it { expect(subject.stdout).to match /[0-9]*\.[0-9]*\.[0-9]*/ }
    end
  end

  describe 'api' do
    describe service 'dillojs-api' do
      it { expect(subject).to be_enabled }
      it { expect(subject).to be_running }
    end

    describe 'app' do
      describe file '/usr/share/nginx/www' do
        it { expect(subject).to exist }
        it { expect(subject).to be_directory }
      end

      %w(app.js  index.html  vendor.css  vendor.js).each do |asset|
        describe file "/usr/share/nginx/www/#{asset}" do
          it { expect(subject).to exist }
          it {expect(subject).to be_file}
        end
      end

      %w(brunch bower).each do |pkg|
        describe command "npm -g ls | grep #{pkg}" do
          it {expect(subject.exit_status).to eq 0}
        end
      end
    end
  end
end
