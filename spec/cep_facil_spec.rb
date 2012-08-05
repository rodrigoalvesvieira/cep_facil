# coding: utf-8
require File.expand_path('spec/spec_helper')

describe CepFacil do
  before(:each) do
    @token = "0E2ACA03-FC7F-4E87-9046-A8C46637BA9D"
  end

  it "has a version" do
    CepFacil::VERSION.should =~ /^\d+\.\d+\.\d+$/
  end

  it "can fetch an address from a CEP" do
    cep = "53417-540"

    address = CepFacil::API.new(cep, token)
    address.should_not be_nil

    address.type.should eql("Rua")
    address.city.should eql("Paulista")
  end

  it "works with non formatted zip codes (CEPs)" do
    cep = "53417540"
    address = CepFacil::API.new(cep, token)
    address.should_not be_nil
  end

  it "works even with zip codes (CEPs) stored as integers" do
    cep = 53417540
    address = CepFacil::API.new(cep, token)
    address.should_not be_nil
  end

  it "can get all 6 attributes (cep, type, state, city, neighborhood, description) from a given CEP" do
    cep = "52060-010"
    address = CepFacil::API.new(cep, token)

    address.cep.should eql("52060010")
    address.type.should eql("Rua")
    address.state.should eql("PE")
    address.city.should eql("Recife")
    address.neighborhood.should eql("Parnamirim")
    address.description.should include("Tude de Melo")
  end

  it "can return a string with the full address" do
    cep = "53417-540"

    address = CepFacil::API.new(cep, token)

    full_version = address.full_format

    full_version.should_not be_nil
    full_version.should eql("Rua Panelas, Paulista - PE, Brasil")
  end

  it "handles correct encoding" do
    cep = "79005-340"

    address = CepFacil::API.new(cep, token)

    address.neighborhood.should eql("Amambaí")
    address.description.should eql("Coronel Camisão")
  end

end

