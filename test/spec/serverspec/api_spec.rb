# encoding: UTF-8

require 'spec_helper'

describe service 'dillojs-api' do
  it { expect(subject).to be_enabled }
  it { expect(subject).to be_running }
end
