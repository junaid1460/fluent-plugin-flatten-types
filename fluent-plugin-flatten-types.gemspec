lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name    = "fluent-plugin-flatten-types"
  spec.version = "0.1.1"
  spec.authors = ["Muhammad junaid"]
  spec.email   = ["mahammad.junaid@smallcase.com"]

  spec.summary       = %q{ Flattens nested json with type annotation}
  spec.description   = %q{ types separated type _n }
  spec.homepage      = "https://smallcase.com"
  spec.license       = "Apache-2.0"

  spec.files         = `git ls-files`.split($/)
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]
  spec.required_ruby_version = '>= 2.1.0'

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 12.0"
  spec.add_development_dependency "test-unit", "~> 3.0"
  spec.add_runtime_dependency "fluentd", [">= 0.14.10", "< 2"]
end
