# coding: utf-8
require "cgi"
require "cep_facil/version"
require "net/http"

module CepFacil
  
  module_function

  # Receives the zip code (CEP) and the Token (get yours at http://cepfacil.com.br) and
  # returns the address referent to that zip code as a hash object.
  #
  # == Example 
  #   require "cep_facil"
  #   cep = "5417-540"
  #   token = "1234567890"
  #   address = CepFacil.get_address(cep, token)
  #
  # == You can also do:
  #   require "cep_facil"
  #   include CepFacil
  #   get_address cep, token
  #
  #   # address is a hash with 6 keys: cep, type, state, city, neighborhood, description
  #
  # Reading them: 
  #   address[:city]
  #   address[:state]
  #
  # Some applications store Brazilian zip codes (CEPs) in formats like "22222222", or "22222-222"
  # or even as an integer. This method accept these three possible formats so you don´t need to format it yourself.
  
  def get_address(zip_code, token)
    zip_code = zip_code.to_s
    
    if zip_code.match(/^[0-9]{5}[-]?[0-9]{3}/)
      zip_code.gsub!("-", "")
      @uri = URI.parse "http://www.cepfacil.com.br/service/?filiacao=#{token}&cep=#{zip_code}&formato=texto"
    else
      @uri = URI.parse "http://www.cepfacil.com.br/service/?filiacao=#{token}&cep=#{zip_code}&formato=texto"
    end
    
    http = Net::HTTP.new(@uri.host, @uri.port)
    call = Net::HTTP::Get.new(@uri.request_uri)
    
    dictionary = {
      "tipo" => :type,
      "cidade" => :city,
      "bairro" => :neighborhood,
      "cep" => :cep,
      "descricao" => :description,
      "uf" => :state
    }
    response = http.request(call)
    address = Hash[* CGI::parse(response.body).map {|key, value| [dictionary[key],value[0]]}.flatten]
  end
  
  # Receives and address hash and returns its extense version
  # == Example
  #   address = CepFacil.get_address "53417-540", "1234456677886545"
  #   CepFacil.full address
  #   # => Rua Panelas, Artur Lundgren II, Paulista-PE, Brasil.
  #
  # == You can also do:
  #   require "cep_facil"
  #   include CepFacil
  #   address = CepFacil.get_address "53417-540", "1234456677886545"
  #   full address
   
  def full(address)
    "#{address[:type]} #{address[:description]}, #{address[:neighborhood]}, #{address[:city]}-#{address[:state]}, Brasil."
  end

end
