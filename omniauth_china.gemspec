# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "omniauth_china/version"

Gem::Specification.new do |s|
  s.name        = "omniauth_china"
  s.version     = OmniauthChina::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Qi He"]
  s.email       = ["qihe229@gmail.com"]
  s.homepage    = "http://rubygems.org/gems/omniauth_china"
  s.summary     = %q{OmniAuth extension: omniauth for china}
  s.description = %q{This is an extention of OmniAuth, it addes Open ID providers in China such as Douban, Sina, Sohu, 163, Tencent, Renren, etc.}

  s.rubyforge_project = "omniauth_china"
  
  s.add_dependency  'oa-core',  '~> 0.2.0'
  s.add_dependency  'oa-oauth', '~> 0.2.0'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
