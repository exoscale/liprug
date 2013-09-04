# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'liprug/version'

Gem::Specification.new do |spec|
  spec.name          = "liprug"
  spec.version       = Liprug::VERSION
  spec.authors       = ["Pierre-Yves Ritschard"]
  spec.email         = ["pyr@spootnik.org"]
  spec.description   = %q{simple operational dashboard}
  spec.summary       = %q{operational dashboard}
  spec.homepage      = "https://github.com/exoscale/liprug"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "sinatra"
  spec.add_dependency "slim"
  spec.add_dependency "redis"
  spec.add_dependency "rdiscount"
  spec.add_dependency "unicorn"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
