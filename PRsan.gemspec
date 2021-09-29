# frozen_string_literal: true

require_relative "lib/PRsan/version"

Gem::Specification.new do |spec|
  spec.name          = "PRsan"
  spec.version       = PRsan::VERSION
  spec.authors       = ["Ayaka Moronaga"]
  spec.email         = ["a.moronaga@everyleaf.com"]

  spec.summary       = "%q{Observe reactions to tweets.}"
  spec.description   = "%q{Observe reactions to tweets.}"
  spec.homepage      = "https://github.com/ayaka-ramens/PRsan"
  spec.license       = "MIT"
  spec.required_ruby_version = ">= 2.4.0"

  spec.metadata["allowed_push_host"] = ""

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/ayaka-ramens/PRsan"
  spec.metadata["changelog_uri"] = "https://github.com/ayaka-ramens/PRsan"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
