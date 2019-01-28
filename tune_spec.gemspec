# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tune_spec/version'

Gem::Specification.new do |spec|
  spec.name          = 'tune_spec'
  spec.version       = TuneSpec::VERSION
  spec.authors       = ['Igor Starostenko']
  spec.email         = ['contactigorstar@gmail.com']

  spec.summary       = "tune_spec_#{TuneSpec::VERSION}"
  spec.description   = 'e2e Ruby tests in Page Objects'
  spec.homepage      = 'https://github.com/igor-starostenko/tune_spec'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
  spec.metadata['yard.run'] = 'yri' # use "yard" to build full HTML docs.

  spec.add_development_dependency 'bundler', '~> 1.16', '>= 1.16.2'
  spec.add_development_dependency 'rubocop', '~> 0.63.1'
  spec.add_development_dependency 'yard', '~> 0.9.12'
  spec.add_development_dependency 'yard-doctest', '~> 0.1.10'
end
