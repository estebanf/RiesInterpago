# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ries_interpagos/version'

Gem::Specification.new do |spec|
  spec.name          = "ries_interpagos"
  spec.version       = RiesInterpagos::VERSION
  spec.authors       = ["Esteban Felipe"]
  spec.email         = ["esteban@allihay.com"]
  spec.description   = "Queries interpago"
  spec.summary       = "Interpago Webservice reapper"
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_dependency "savon","2.2.0"

end
