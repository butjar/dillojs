require 'spec_helper'

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
