# coding: utf-8

lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fastlane/plugin/deploy_aws_s3_cloudfront/version'

Gem::Specification.new do |spec|
  spec.name          = 'fastlane-plugin-deploy_aws_s3_cloudfront'
  spec.version       = Fastlane::DeployAwsS3Cloudfront::VERSION
  spec.author        = 'Hector'
  spec.email         = 'hector@mrjeffapp.com'

  spec.summary       = 'Deploy local directory to AWS S3 bucket and invalidate CloudFront'
  spec.homepage      = "https://jeff-labs.github.io/fastlane-plugin-deploy_aws_s3_cloudfront"
  spec.license       = "MIT"

  spec.files         = Dir["lib/**/*"] + %w(README.md LICENSE)
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  # Don't add a dependency to fastlane or fastlane_re
  # since this would cause a circular dependency

  spec.add_dependency('aws-sdk-s3', '~> 1.36')
  spec.add_dependency('aws-sdk-cloudfront', '~> 1.15')
  spec.add_dependency('mimemagic', '~> 0.3')

  spec.add_development_dependency('pry')
  spec.add_development_dependency('bundler')
  spec.add_development_dependency('rspec')
  spec.add_development_dependency('rspec_junit_formatter')
  spec.add_development_dependency('rake')
  spec.add_development_dependency('rubocop', '0.49.1')
  spec.add_development_dependency('rubocop-require_tools')
  spec.add_development_dependency('simplecov')
  spec.add_development_dependency('fastlane', '>= 2.121.1')
end
