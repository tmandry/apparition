require 'apparition/rspec'
require 'rspec/mocks'

describe "visit", :type => :regression do
  it "visits the given page" do
    app = double(call: [200, {}, ["hello world"]])
    Apparition.app = app
    Apparition.current_session.start

    app.should_receive(:call)
    visit '/'

    visit '/__shutdown__'
    Apparition.current_session.reset!
  end
end
