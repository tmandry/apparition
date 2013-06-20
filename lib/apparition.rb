require 'apparition/version'
require 'apparition/server'
require 'debugger'

module Apparition
  class << self
    attr_accessor :app

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
  end
end
