require 'rack'
require 'net/http'

module Apparition
  class Server
    class Middleware
      def initialize(app)
        @app = app
      end

      def call(env)
        case env["PATH_INFO"]
        when "/__shutdown__"
          Rack::Handler::WEBrick.shutdown
          [200, {}, []]
        when "/__ping__"
          [200, {}, [object_id.to_s]]
        else
          @app.call(env)
        end
      end
    end

    attr_reader :port, :middleware

    def initialize(app, port = nil)
      @app = app
      @port = port || find_available_port
      @middleware = Middleware.new(app)
      @server_thread = nil
    end

    def boot
      @server_thread ||= Thread.new do
        require 'rack/handler/webrick'
        Rack::Handler::WEBrick.run(@middleware, :Port => @port, :AccessLog => [], :Logger => WEBrick::Log::new(nil, 0))
        # Rack::Handler::WEBrick.run(@middleware, :Port => @port)
      end

      Timeout.timeout(30) do
        until running? do
          @server_thread.join(0.1)
        end
      end
      self
    rescue Timeout::Error
      raise "Rack app timed out while trying to start server"
    end

    private

    def running?
      return false if @server_thread && @server_thread.join(0)

      begin
        res = Net::HTTP.start('localhost', @port) { |http| http.get('/__ping__') }
      rescue SystemCallError
        return false
      end

      if res.is_a?(Net::HTTPSuccess) or res.is_a?(Net::HTTPRedirection)
        return res.body == @middleware.object_id.to_s
      end
    end

    def find_available_port
      server = TCPServer.new('127.0.0.1', 0)
      server.addr[1]
    ensure
      server.close if server
    end
  end
end
