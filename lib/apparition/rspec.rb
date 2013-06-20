require 'apparition'
require 'apparition/dsl'
require 'rspec/core'

RSpec.configure do |config|
  config.include Apparition::DSL, :type => :regression
end
