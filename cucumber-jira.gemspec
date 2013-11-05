# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cucumber/jira/version'

Gem::Specification.new do |spec|
  spec.name          = 'cucumber-jira'
  spec.version       = Cucumber::Jira::VERSION
  spec.authors       = ['Erran Carey']
  spec.email         = ['me@errancarey.com']
  spec.description   = %q{Multi-version JIRA integration for cucumber}
  spec.summary       = %q{JIRA integration for cucumber}
  spec.homepage      = 'https://github.com/ipwnstuff/cucumber-jira'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
  spec.add_runtime_dependency     'jiraSOAP', '~> 0.10'
end
