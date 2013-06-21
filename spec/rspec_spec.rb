require 'apparition/rspec'
require 'rspec/mocks'

class MockApp
  attr_reader :was_called
  def call(env)
    @was_called = true
    [200, {}, ["hello world"]]
  end
end

describe "visit", :type => :regression do
  it "visits the given page" do
    Apparition.app = MockApp.new
    Apparition.reset!

    visit '/'
    # TODO: don't depend on selenium for spec
    wait = Selenium::WebDriver::Wait.new(:timeout => 10)
    wait.until { Apparition.app.was_called }
  end
end

describe "save_screenshot", :type => :regression do
  it "saves a screenshot to the given path" do
    Apparition.app = MockApp.new
    Apparition.reset!

    filename = "tmp/myshot.png"

    visit '/'
    save_screenshot(filename)
    File.exists?(filename).should be_true
    File.delete(filename)
  end
end
