require 'apparition/driver'
require 'apparition/server'

module Apparition
  class Session
    attr_accessor :app
    attr_reader :driver

    def initialize(app)
      @app = app
      @driver = Apparition::Driver.new
    end

    def start
      server.boot
      puts "Listening at http://localhost:#{server.port}/"
    end

    def join(*args)
      server.join(*args)
    end

    def wrapped_app
      server.middleware
    end

    def server
      @server ||= Server.new(Apparition.app)
    end

    def reset!
      # TODO shutdown server
      @server = nil
    end
  end
end
