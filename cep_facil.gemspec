# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "cep_facil/version"

Gem::Specification.new do |s|
  s.name        = "cep_facil"
  s.version     = CepFacil::VERSION
  s.authors     = ["Rodrigo Alves Vieira"]
  s.email       = ["rodrigovieira1994@gmail.com"]
  s.homepage    = "http://github.com/rodrigoalvesvieira/cep_facil"
  s.summary     = %q{Wrapper para o serviço cepfacil.com.br}
  s.description = %q{Wrapper Ruby para o serviço cepfacil.com.br}
  s.rubyforge_project = "cep_facil"
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  s.add_dependency("rake", "0.9.2.2")
  s.add_development_dependency("rspec", "~> 2.10.0")
end
