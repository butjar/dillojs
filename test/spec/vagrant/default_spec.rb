# encoding: UTF-8

require 'spec_helper'

describe 'dillojs::default' do
  include_examples 'api'
  include_examples 'app'
  include_examples 'mongodb'
  include_examples 'nginx'
  include_examples 'nodejs'
end
