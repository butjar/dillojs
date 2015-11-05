require 'spec_helper'

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
