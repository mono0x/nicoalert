# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "nicoalert/version"

Gem::Specification.new do |s|
  s.name        = "nicoalert"
  s.version     = Nicoalert::VERSION
  s.authors     = ["mono"]
  s.email       = ["mono@monoweb.info"]
  s.homepage    = "http://monoweb.info/"
  s.summary     = %q{A Ruby wrapper of Niconama Alert API}

  s.rubyforge_project = "nicoalert"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_runtime_dependency "rest-client"
  s.add_runtime_dependency "nokogiri"
end
