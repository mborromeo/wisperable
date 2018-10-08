
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "wisperable/version"

Gem::Specification.new do |spec|
  spec.name          = "wisperable"
  spec.version       = Wisperable::VERSION
  spec.authors       = ["Marco Borromeo"]
  spec.email         = ["marco@marcoborromeo.com"]

  spec.summary       = %q{Configure and Broadcast ActiveModel events via Wisper}
  spec.homepage      = "https://github.com/mborromeo/wisperable"
  spec.license       = "MIT"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'activesupport', '~> 5.2'
  spec.add_runtime_dependency 'wisper', '~> 2.0'

  spec.add_development_dependency 'activerecord', '~> 5.2'
  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'rake', '~> 12.3'
  spec.add_development_dependency 'rspec', '~> 3.8'
  spec.add_development_dependency 'simplecov', '~> 0.16'
  spec.add_development_dependency 'sqlite3', '~> 1.3'

end
