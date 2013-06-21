require 'selenium-webdriver'

module Apparition
  class Driver
    def browser
      unless @browser
        @browser = Selenium::WebDriver.for(options[:browser])
      end
      @browser
    end

    def visit(path)
      browser.navigate.to(path)
    end

    def save_screenshot(path)
      browser.save_screenshot(path)
    end

    def options
      {
        browser: :chrome
      }
    end
  end
end
