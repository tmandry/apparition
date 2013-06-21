require 'selenium-webdriver'

module Apparition
  class Driver
    attr_reader :browser

    def browser
      unless @browser
        @browser = Selenium::WebDriver.for(options[:browser])
      end
    end

    def visit(path)
      browser.navigate.to(path)
    end

    def options
      {
        browser: :phantomjs
      }
    end
  end
end
