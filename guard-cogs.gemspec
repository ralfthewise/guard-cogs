# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'guard/cogs/version'

Gem::Specification.new do |spec|
  spec.name          = 'guard-cogs'
  spec.version       = Guard::CogsVersion::VERSION
  spec.authors       = ['Tim Garton']
  spec.email         = ['garton.tim@gmail.com']
  spec.summary       = 'Guard gem for sprockets'
  spec.description   = 'Guard::Cogs packages your coffeescript, javascript, sass, and css.'
  spec.homepage      = 'https://rubygems.org/gems/guard-cogs'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'guard'
  spec.add_dependency 'coffee-script'
  spec.add_dependency 'uglifier'
  spec.add_dependency 'sass'
  spec.add_dependency 'yui-compressor'
  spec.add_dependency 'sprockets', '~> 2.0'
  spec.add_dependency 'sprockets-sass'

  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rake'
end
