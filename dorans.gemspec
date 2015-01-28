lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dorans/version'

Gem::Specification.new do |s|
  s.name        = 'dorans'
  s.version     = Dorans::VERSION
  s.summary     = "Ruby client for the Riot Games API"
  s.description = "A client for interacting with the League of Legends REST API."
  s.authors     = ["Eric Johnson"]
  s.email       = 'erjohnson.pdx@gmail.com'
  s.files       = ["lib"]
  s.homepage    = 'https://github.com/erjohnson/dorans-ruby'
  s.license     = 'MIT'

  s.files         = `git ls-files -z`.split("\x0")
  s.executables   = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ["lib"]

  s.add_dependency "hurley"

  s.add_development_dependency "bundler", "~> 1.6"
  s.add_development_dependency "rake"
end