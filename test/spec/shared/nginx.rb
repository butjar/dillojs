# encoding: UTF-8

shared_examples 'nginx' do
  describe package 'nginx' do
    it { expect(subject).to be_installed }
  end

  describe service 'nginx' do
    it { expect(subject).to be_enabled }
    it { expect(subject).to be_running }
  end

  describe port(80), docker: false do
    it { expect(subject).to be_listening }
  end

  describe file '/etc/nginx/nginx.conf' do
    let(:content) { subject.content }
    let(:root_location) { 'location / {' }
    let(:api_location) { 'location /api/ {' }

    it { expect(subject).to exist }
    it { expect(subject).to be_file }
    it { expect(content).to include(root_location) }
    it { expect(content).to include(api_location) }
  end
end
