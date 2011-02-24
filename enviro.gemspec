# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "enviro/version"

Gem::Specification.new do |s|
  s.name        = "enviro"
  s.version     = Enviro::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Bram Swenson"]
  s.email       = ["bram@craniumisajar.com"]
  s.homepage    = ""
  s.summary     = %q{ Add rails like application wide environment configuration, logging and more. }
  s.description = %q{ Add rails like application wide environment configuration, logging and more. }

  s.rubyforge_project = "enviro"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency('cucumber')
  s.add_development_dependency('rspec')
  s.add_development_dependency('autotest-standalone')
  s.add_development_dependency('autotest-growl')
  s.add_development_dependency('simplecov')
  s.add_development_dependency('ruby-debug19')
end
