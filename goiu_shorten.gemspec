# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "goiu_shorten/version"

Gem::Specification.new do |s|
  s.name        = "goiu_shorten"
  s.version     = GoiuShorten::VERSION
  s.authors     = ["David Poindexter"]
  s.email       = ["drpoindexter@gmail.com"]
  s.homepage    = "https://github.com/mtheoryx/goiu_shorten"
  s.summary     = %q{API interface to IU GoIU URL shortening service.}
  s.description = %q{Provides easy interaction with the IU GoIU URL shortening service.}

  s.rubyforge_project = "goiu_shorten"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec'

  s.add_runtime_dependency 'savon'
end
