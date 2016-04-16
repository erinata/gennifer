# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gennifer/version'
# coding: utf-8

Gem::Specification.new do |spec|
  spec.name          = "gennifer"
  spec.version       = Gennifer::VERSION
  spec.authors       = ["Chungsang Tom Lam"]
  spec.email         = ["erinata@gmail.com"]

  spec.summary       = %q{This is a gem for generating files/projects using customizable templates called recipes.}
  spec.description   = %q{This is a gem for generating files/projects using recipes. The default recipes included ruby python and latex files. Erb template supported. }
  spec.homepage      = "https://github.com/erinata/gennifer"
  spec.license       = "All rights reserved"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
end
