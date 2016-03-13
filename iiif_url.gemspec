# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'iiif_url/version'

Gem::Specification.new do |spec|
  spec.name          = "iiif_url"
  spec.version       = IiifUrl::VERSION
  spec.authors       = ["Jason Ronallo"]
  spec.email         = ["jronallo@gmail.com"]

  spec.summary       = %q{Create and parse IIIF Image API URLs}
  spec.description   = %q{Create IIIF Image API URLs from parameters; parse IIIF Image API URLs into parameters.}
  spec.homepage      = "https://github.com/NCSU-Libraries/iiif_url"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "colorize"
end
