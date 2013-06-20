require "rack"

module Apparition
  class Server
    class Middleware
      def initialize(app)
        @app = app
      end

      def call(env)
        puts "Middleware#call here"
        @app.call(env)
      end
    end

    attr_reader :port, :middleware

    def initialize(app, port = 1337)
      @app = app
      @port = port
      @middleware = Middleware.new(app)
      @server_thread = nil
    end

    def boot
      @server_thread ||= Thread.new do
        require 'rack/handler/webrick'
        Rack::Handler::WEBrick.run(@middleware, :Port => @port, :AccessLog => [], :Logger => WEBrick::Log::new(nil, 0))
      end
      self
    end

    def shutdown
      Rack::Handler::WEBrick.shutdown
    end

    def join(*args)
      @server_thread.join(*args)
    end
  end
end
