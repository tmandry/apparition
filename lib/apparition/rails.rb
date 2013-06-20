# To be included in spec_helper (or similar) of user application.
require 'apparition'
require 'rails'

Apparition.app = Rack::Builder.new do
  map "/" do
    run Rails.application
  end
end.to_app
