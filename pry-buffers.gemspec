# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "pry-buffers/version"

Gem::Specification.new do |s|
  s.name        = "pry-buffers"
  s.version     = Pry::Buffers::VERSION
  s.authors     = ["David Barral"]
  s.email       = ["contact@davidbarral.com"]
  s.homepage    = ""
  s.summary     = %q{Use buffers to edit and execute arbitrary code}
  s.description = %q{Use buffers to edit and execute arbitrary code}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency "pry"
  s.add_dependency "pry-doc"
end
