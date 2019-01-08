# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ssm_to_env/version'

Gem::Specification.new do |spec|
  spec.name          = 'ssm_to_env'
  spec.version       = SsmToEnv::VERSION
  spec.authors       = ['Rob Di Marco']
  spec.email         = ['rob@elocal.com']

  spec.summary       = 'Gem that takes AWS SSM parameters and adds them to the ENV hash'
  spec.homepage      = 'https://github.com/eLocal/ssm_to_env'
  spec.license       = 'MIT'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.require_paths = ['lib']

  spec.add_dependency 'aws-sdk-ssm'
  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
