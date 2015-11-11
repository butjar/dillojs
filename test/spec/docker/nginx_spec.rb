# encoding: UTF-8

require 'spec_helper'

describe 'dillojs' do
  describe 'nginx' do
    before(:all) do
      set :docker_container, 'dillojs-nginx'
    end

    include_examples 'nginx'
  end
end
