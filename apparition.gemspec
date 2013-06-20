# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'apparition/version'

Gem::Specification.new do |spec|
  spec.name          = "apparition"
  spec.version       = Apparition::VERSION
  spec.authors       = ["Tyler Mandry"]
  spec.email         = ["tmandry@gmail.com"]
  spec.description   = %q{Catches visual glitches so they can't haunt your webapp.}
  spec.summary       = %q{Visual regression tester}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "debugger"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "capybara"
end
