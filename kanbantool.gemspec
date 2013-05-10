# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'kanbantool/version'

Gem::Specification.new do |spec|
  spec.name          = "kanbantool"
  spec.version       = KanbanTool::VERSION
  spec.authors       = ["Tim Blair"]
  spec.email         = ["tim@bla.ir"]
  spec.description   = %q{Easy access to Kanban Tool's API}
  spec.summary       = %q{Easy access to Kanban Tool's API}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "httparty", "~> 0.11.0"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "webmock", "< 1.10.0"
  spec.add_development_dependency "vcr", "~> 2.4.0"
end
