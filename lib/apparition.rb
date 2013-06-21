require 'apparition/version'
require 'apparition/server'
require 'apparition/session'
require 'debugger'

module Apparition
  class << self
    attr_accessor :app
    attr_reader :current_session

    def current_session
      @session ||= Apparition::Session.new(app)
    end

    def reset!
      @session = nil
    end
  end
end
