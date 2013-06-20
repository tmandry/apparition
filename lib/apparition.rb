require 'apparition/version'
require 'apparition/server'
require 'debugger'

module Apparition
  class << self
    attr_accessor :app
    attr_reader :server

    def start
      @server = Server.new(Apparition.app).boot
      puts "Listening at http://localhost:#{@server.port}/"
    end

    def join(*args)
      @server.join(*args)
    end
  end
end
