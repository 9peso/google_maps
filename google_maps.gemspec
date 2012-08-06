# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "google_maps/version"

Gem::Specification.new do |s|
  s.name        = "google_maps"
  s.version     = GoogleMaps::VERSION
  s.authors     = ["Bakuta Andrey"]
  s.email       = ["dra1n86@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Gives convenient helpers for adding google maps to your application.}
  s.description = %q{Gives convenient helpers for adding google maps to your application.}

  s.rubyforge_project = "google_maps"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
end
