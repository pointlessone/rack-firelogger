# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "rack/firelogger/version"

Gem::Specification.new do |s|
  s.name = %q{rack-firelogger}
  s.version = Rack::Firelogger::VERSION

  s.authors = ["Alexander Mankuta"]
  s.email = ["cheba@pointlessone.org"]
  s.summary = %q{Middleware for enabling FireLogger in Rack apps}
  s.description = %q{Middleware that will make Rack-based apps log to Firebuge. Read more about FireLogger at http://firelogger.binaryage.com/ Fork the project here: http://github.com/cheba/rack-firelogger}
  s.extra_rdoc_files = [
    "README.md"
  ]
  s.files = Dir.glob("{bin,lib}/**/*") + %w(LICENSE README.md ROADMAP.md CHANGELOG.md)
  s.homepage = %q{http://github.com/cheba/rack-firelogger}
  s.rdoc_options = ["--charset=UTF-8"]
  s.rubygems_version = %q{1.3.7}
  s.test_files = spec.test_files = Dir.glob('test/*_test.rb')

  s.add_dependency("rack", ">= 0")
end
