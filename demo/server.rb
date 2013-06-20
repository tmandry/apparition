require 'rack'
require 'rack/lobster'
require 'apparition'

Apparition.app = Rack::Builder.new do
  run Rack::Lobster.new
end.to_app

Apparition.start
Apparition.join
