require 'spec_helper'
require 'apparition'
require 'rack'
require 'rack/lobster'

describe "Apparition server" do
  before(:each) do
    app = Rack::Builder.new do
      run Rack::Lobster.new
    end.to_app
    apparition_session = Apparition::Session.new(app)
    @session = Capybara::Session.new(:rack_test, apparition_session.wrapped_app)
  end
  after(:each) do
    Apparition.reset!
  end

  it "acts as middleware" do
    @session.visit '/'
    @session.should have_content('flip')
  end
end
