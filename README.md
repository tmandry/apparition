# Apparition

Apparition makes it easy to do visual regression testing of your Rack-based
webapp. It can run tests in headless or in real browsers using
[Selenium](http://docs.seleniumhq.org/), at a variety of different sizes. Write
specs like this:

```ruby
# Take 1
remember "Home page" do
  its "default appearance" do
    visit '/'
    capture 'body'
  end

  its "user menu" do
    visit '/'
    find '.user-button'.click
    capture '.user-menu'
  end
end

# Take 2
## regression/home_page_spec.rb
remember "Default appearance" do
  it "should not change" do
    visit '/'
    capture 'body'
  end
  it "should look the same on modern browsers" do
    visit '/'
    capture('body').should look_the_same_in [:chrome, :firefox, :safari, :ie10]
  end
end

# I still don't know if this is the right way of tackling this
# problem... We may want to look at this more in terms of accepting visual changes
# as they come, and writing code that describes the diffs that we make people
# review.

# Take 3
## regression/home_page_spec.rb
remember "Default appearance" do
  it "should be reviewed" do
    visit '/'
    diff('body').across_versions
    # OR
    review_changes_to 'body'
  end
  it "should look the same on modern browsers" do
    visit '/'
    diff('body').in_browsers [:chrome, :firefox, :safari, :ie10]
    # OR
    review_differences_in('body').in_browsers [:chrome, :firefox, :safari, :ie10]
  end
end
```

and find out about inadvertent changes made to the appearance of your site right
away. Apparition can test your site in all of the browsers and configurations
that you care about, and tell you when any one of them changes. You can use it
to spot check changes you make to your stylesheets, or integrate it into your
continuous integration system to make sure all visual changes are approved. It's
up to you.

## Why do regression testing

The reasons for doing regression testing are the same as the reasons for doing
any testing: Rapid iteration with increased confidence that your app still
works. ...

### Is this gem a good idea?

We think visual regression testing is a good idea, and interest in projects such
as [PhantomCSS](https://github.com/Huddle/PhantomCSS) demonstrate that other
people are interested in it, too. The problem is the lack of tools for a
structured workflow. Apparition fixes that problem.

## Installation

Add this line to your application's Gemfile:

    gem 'apparition'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install apparition

## Usage

TODO: Write usage instructions here

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
