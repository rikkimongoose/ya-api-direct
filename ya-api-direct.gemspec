# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'ya/api/direct/version'

Gem::Specification.new do |s|
  s.name        = 'ya-api-direct'
  s.version     = '0.0.1'
  s.date        = '2016-09-05'
  s.summary     = "Yandex Direct API v5"
  s.description = "Ruby implementation for Yandex Direct API of versions 5, 4 and 4 Live"
  s.authors     = %w("Alexander Teut")
  s.email       = 'alexander.a.teut@gmail.com'
  s.files       = %w(LICENSE.md README.md ya-api-direct.gemspec) + Dir['lib/api/direct/*.rb']
  s.homepage    = 'http://rubygems.org/gems/ya-api-direct'
  s.license     = 'MIT'
  s.version     = Ya::API::Direct::Version
end