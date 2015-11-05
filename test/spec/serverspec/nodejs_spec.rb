# encoding: UTF-8

require 'spec_helper'

describe command 'node -v' do
  it { expect(subject.stdout).to match(/v[0-9]*\.[0-9]*\.[0-9]*/) }
end

describe command 'npm -v' do
  it { expect(subject.stdout).to match(/[0-9]*\.[0-9]*\.[0-9]*/) }
end
