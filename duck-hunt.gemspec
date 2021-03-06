$:.push File.expand_path("../lib", __FILE__)

# The gem's version:
require "duck-hunt/version"

Gem::Specification.new do |s|
  s.name        = "duck-hunt"
  s.version     = DuckHunt::VERSION
  s.authors     = ["Thomas Cannon"]
  s.email       = ["hello@thomascannon.me"]
  s.homepage    = "https://github.com/tcannonfodder/duck-hunt"
  s.description = "Dependency-free object validation library for Ruby 1.8.7+"
  s.summary     = "Dependency-free object validation library for Ruby 1.8.7+"

  s.files = Dir["lib/**/*"] + [
    "LICENSE",
    "Rakefile",
    "README.md"
  ]
  s.test_files = Dir["test/**/*"]

  s.add_development_dependency 'minitest'
  s.add_development_dependency 'mocha'
  s.add_development_dependency 'rake'
end
