# frozen_string_literal: true

require_relative 'lib/method_annotation/version'

Gem::Specification.new do |spec|
  spec.name          = 'method_annotation'
  spec.version       = MethodAnnotation::VERSION
  spec.authors       = ['Tomohiro Nishimura']
  spec.email         = ['tomohiro68@gmail.com']

  spec.summary       = 'Annotate method with anything.'
  spec.description   = 'Annotate method with anything. Symbol, String and so on'
  spec.homepage      = 'https://githuc.com/Sixeight/method_annotation'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.5.0')

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage
  spec.metadata['changelog_uri'] = format('%s/blob/master/CHANGELOG.md', spec.homepage)

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.require_paths = ['lib']
end
