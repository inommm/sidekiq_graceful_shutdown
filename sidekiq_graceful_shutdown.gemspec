require_relative 'lib/sidekiq_graceful_shutdown/version'

Gem::Specification.new do |spec|
  spec.name          = "sidekiq_graceful_shutdown"
  spec.version       = SidekiqGracefulShutdown::VERSION
  spec.authors       = ["inomata724"]
  spec.email         = ["inomata724@gmail.com"]

  spec.summary       = %q{}
  spec.description   = %q{}
  spec.homepage      = "https://github.com/inomata724/sidekiq_graceful_shutdown"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "rails", '>= 5.0.0'
  spec.add_runtime_dependency "sidekiq", '>= 4.0.0'
end
