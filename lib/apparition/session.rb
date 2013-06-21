require 'apparition/driver'
require 'apparition/server'

module Apparition
  class Session
    attr_accessor :app
    attr_reader :driver

    def initialize(app)
      @app = app
      @driver = Apparition::Driver.new
      server.boot
      puts "Listening at http://localhost:#{server.port}/"
    end

    def wrapped_app
      server.middleware
    end

    def reset!
      # TODO shutdown server
      @server = nil
    end

    def visit(path)
      path = "/#{path}" if path[0] != '/'
      url = "http://localhost:#{server.port}#{path}"
      driver.visit(url)
    end

    def save_screenshot(path)
      driver.save_screenshot(path)
    end

    private

    def server
      @server ||= Server.new(app)
    end
  end
end
