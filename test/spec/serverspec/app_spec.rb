# encoding: UTF-8

require 'spec_helper'

describe file '/usr/share/nginx/www' do
  it { expect(subject).to exist }
  it { expect(subject).to be_directory }
end

%w(app.js  index.html  vendor.css  vendor.js).each do |asset|
  describe file "/usr/share/nginx/www/#{asset}" do
    it { expect(subject).to exist }
    it { expect(subject).to be_file }
  end
end

%w(brunch bower).each do |pkg|
  describe command "npm -g ls | grep #{pkg}" do
    it { expect(subject.exit_status).to eq 0 }
  end
end
