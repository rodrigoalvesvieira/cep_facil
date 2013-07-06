$:.push File.expand_path("../lib", __FILE__)
require "cep_facil/version"

Gem::Specification.new do |s|
  s.name              = "cep_facil"
  s.version           = CepFacil::VERSION
  s.authors           = ["Rodrigo Alves"]
  s.email             = ["rodrigovieira1994@gmail.com"]
  s.homepage          = "http://github.com/rodrigoalvesvieira/cep_facil"
  s.summary           = %q{Wrapper para o serviço cepfacil.com.br}
  s.description       = %q{Wrapper Ruby para o serviço cepfacil.com.br}
  s.rubyforge_project = "cep_facil"
  s.files             = `git ls-files`.split("\n")
  s.test_files        = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables       = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths     = ["lib"]

  s.rdoc_options = ["--title", "Wrapper Ruby para a API do CepFacil", "--main", "README.md"]
  s.licenses = ["MIT"]

  s.add_dependency("rake", "~> 10.1.0")
  s.add_dependency("json", "~> 1.8.0")

  s.add_development_dependency("rspec", "~> 2.13.0")
end