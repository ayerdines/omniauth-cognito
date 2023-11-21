# frozen_string_literal: true

$LOAD_PATH.push File.expand_path("../lib", __FILE__)

require "omniauth-cognito/version"

Gem::Specification.new do |spec|
  spec.name = "omniauth-cognito"
  spec.version = OmniAuth::Cognito::VERSION
  spec.authors = ["Dinesh Budhayer"]
  spec.email = ["budhayer96d@gmail.com"]

  spec.summary = "OmniAuth OAuth2 strategy for Cognito using authorization code grant."
  spec.description = "OmniAuth OAuth2 strategy for Cognito using authorization code grant."
  spec.homepage = "https://github.com/ayerdines/omniauth-cognito.git"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/ayerdines/omniauth-cognito.git"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ spec/ Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  spec.add_runtime_dependency "omniauth", "~> 2.0", ">= 2.0.4"
  spec.add_runtime_dependency "omniauth-oauth2", "~> 1.7", ">= 1.7.0"

  spec.add_development_dependency "bundler", "~> 2.4", ">= 2.4.0"
  spec.add_development_dependency "rake", "~> 13.0", ">= 13.0.0"
  spec.add_development_dependency "rspec", "~> 3.0", ">= 3.6.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
