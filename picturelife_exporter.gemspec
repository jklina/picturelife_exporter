# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'picturelife_exporter/version'

Gem::Specification.new do |spec|
  spec.name          = "picturelife_exporter"
  spec.version       = PicturelifeExporter::VERSION
  spec.authors       = ["Josh Klina"]
  spec.email         = ["joshua.klina@gmail.com"]

  spec.summary       = %q{Save my photos}
  spec.description   = %q{Save my photos}
  spec.homepage      = "http://none.com"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "httparty"
  spec.add_dependency "open_uri_redirections"
  spec.add_dependency "ruby-progressbar"
  spec.add_dependency "thor"

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "pry"
end
