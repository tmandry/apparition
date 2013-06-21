require 'apparition/rspec'
require 'rspec/mocks'

describe "visit", :type => :regression do
  it "visits the given page" do
    class MockApp
      attr_reader :was_called
      def call(env)
        @was_called = true
        [200, {}, ["hello world"]]
      end
    end
    Apparition.app = MockApp.new
    Apparition.reset!

    visit '/'
    debugger
    # TODO: don't depend on selenium for spec
    wait = Selenium::WebDriver::Wait.new(:timeout => 6)
    wait.until { Apparition.app.was_called }
  end
end
