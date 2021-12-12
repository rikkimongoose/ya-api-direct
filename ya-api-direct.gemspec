# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ya/api/direct/version'

Gem::Specification.new do |s|
  s.name        = 'ya-api-direct'
  s.version     = Ya::Api::Direct::VERSION
  s.date        = '2021-12-12'
  s.summary     = "Yandex Direct API v5, v4 and v4 Live"
  s.description = "Ruby implementation for Yandex Direct API of versions 5, 4 and 4 Live"
  s.authors     = "Rikki Mongoose"
  s.email       = 'alexander.a.teut@gmail.com'
  s.homepage    = 'http://rubygems.org/gems/ya-api-direct'
  s.license     = 'MIT'

  s.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  s.bindir        = "exe"
  s.executables   = s.files.grep(%r{^exe/}) { |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "bundler", ">= 2.2.33"
  s.add_development_dependency "rake", ">= 12.3.3"
  s.add_development_dependency "minitest", "~> 5.0"
end
