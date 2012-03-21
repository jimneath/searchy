# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "searchy/version"

Gem::Specification.new do |s|
  s.name        = "searchy"
  s.version     = Searchy::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["jimneath@gmail.com"]
  s.email       = ["jimneath@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{The simplest search gem}
  s.description = %q{The simplest search gem}

  s.rubyforge_project = "searchy"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  
  s.add_dependency 'activerecord', '>= 3.0.0'
end
