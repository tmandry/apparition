require 'spec_helper'
require 'apparition'
require 'rack'
require 'rack/lobster'

describe "Apparition server" do
  before(:each) do
    Apparition.app = Rack::Builder.new do
      run Rack::Lobster.new
    end.to_app
    @session = Capybara::Session.new(:rack_test, Apparition.current_session.wrapped_app)
  end
  after(:each) do
    Apparition.current_session.reset!
  end

  it "acts as middleware" do
    @session.visit '/'
    @session.should have_content('flip')
  end
end
