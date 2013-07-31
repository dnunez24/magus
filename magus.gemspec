# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'magus/version'

Gem::Specification.new do |spec|
  spec.name          = "magus"
  spec.version       = Magento::VERSION
  spec.authors       = ["Dave Nunez"]
  spec.email         = ["dnunez24@gmail.com"]
  spec.description   = %q{Magento API wrapper in Ruby}
  spec.summary       = %q{An easy-to-use Ruby wrapper for all the Magento core API types (XML-RPC, SOAP, REST)}
  spec.homepage      = ""
  spec.license       = "MIT"
  spec.rubyforge_project = "magus"
  spec.required_ruby_version = ">= 1.9.3"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "savon", "~> 2.2"

  spec.add_development_dependency "rake"
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rspec", "~> 2.14"
  spec.add_development_dependency "cucumber", "~> 1.3"
  spec.add_development_dependency "aruba", "~> 0.5"
  spec.add_development_dependency "vcr", "~> 2.2"
  spec.add_development_dependency "webmock", "~> 1.11.0"
end
