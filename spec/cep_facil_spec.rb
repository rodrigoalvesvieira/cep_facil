# coding: utf-8
require File.expand_path('spec/spec_helper')

describe CepFacil do
  before(:each) do
    @token = "0E2ACA03-FC7F-4E87-9046-A8C46637BA9D"
    @conn = CepFacil::API.new @token
  end

  it "has a version" do
    CepFacil::VERSION.should =~ /^\d+\.\d+\.\d+$/
  end

  it "can authenticate" do
    @conn.should_not be_nil
  end

  it "can fetch an address from a CEP" do
    cep = "53416-540"

    address = @conn.get_address(cep)
    address.should_not be_nil

    address.type.should eql("RUA")
    address.city.should eql("PAULISTA")
  end

  it "works with non formatted zip codes (CEPs)" do
    cep = "53416540"
    address = @conn.get_address(cep)
    address.should_not be_nil
  end

  it "works even with zip codes (CEPs) stored as integers" do
    cep = 53417540
    address = @conn.get_address(cep)
    address.should_not be_nil
  end

  it "can get all 6 attributes (cep, type, state, city, neighborhood, street) from a given CEP" do
    cep = "52060-010"
    address = @conn.get_address(cep)

    address.zip_code.should eql("52060010")
    address.type.should eql("RUA")
    address.state.should eql("PE")
    address.city.should eql("RECIFE")
    address.neighborhood.should eql("PARNAMIRIM")
    address.street.should include("JOÃO TUDE DE MELO")
  end

  it "can return a string with the full address" do
    cep = "53417-540"

    address = @conn.get_address(cep)
    full_version = address.full_format

    full_version.should_not be_nil
  end

  it "handles correct encoding" do
    cep = "79005-340"

    address = @conn.get_address(cep)

    address.neighborhood.should eql("AMAMBAÍ")
    address.street.should eql("CORONEL CAMISÃO")
  end

  it "can tell if a address is valid" do
    cep = "79005-340"

    address = @conn.get_address(cep)
    address.valid?.should be_true
  end

end