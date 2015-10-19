# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'yarr/version'

Gem::Specification.new do |spec|
  spec.name = 'yarr'
  spec.version = Yarr::VERSION
  spec.authors = ['Brett Suwyn']
  spec.email = ['brett@suwyn.com']

  spec.summary = %q{A CMS for your Rails applications}
  spec.description = %q{Yarr is a lightweight CMS that integrates with your existing Rails applications}
  spec.homepage = 'http://www.github.com/webflint/yarr'

  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = ''
  else
    raise 'RubyGems 2.0 or newer is required to protect against public gem pushes.'
  end

  spec.files = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'rails', '>= 3.1'
  spec.add_dependency('i18n-active_record')

  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec'
end
