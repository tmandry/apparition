require "rack"

module Apparition
  class Server
    class Middleware
      def initialize(app)
        @app = app
      end

      def call(env)
        puts "Middleware#call here"
        if (env["PATH_INFO"] == "/__shutdown__")
          Rack::Handler::WEBrick.shutdown
        else
          @app.call(env)
        end
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

    def join(*args)
      @server_thread.join(*args)
    end
  end
end
