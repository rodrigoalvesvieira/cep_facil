# coding: utf-8
require "cep_facil/version"
require "net/http"

module CepFacil
  
  # Recebe o CEP e o Token (obtenha o seu em http://cepfacil.com.br) e 
  # retorna o endereço reference ao CEP passado. 
  #
  # == Exemplo 
  # require "cep_facil"
  # cep = "5417-540"
  # token = "1234567890"
  # CepFacil.get_address(cep, token)
  # Retorna o endereço daquele cep em forma de Hash.
  # Esse hash tem 6 chaves: cep, type, state, city, neighborhood, description
  
  # Algumas pessoas guardam o CEP na forma "22222222", outras como "22222-222"
  # outras até como inteiro.
  # O método CepFacil.get_address aceita as três formas.
  
  def self.get_address(zip_code, token)
    zip_code = zip_code.to_s
    
    if zip_code.match(/^[0-9]{5}[-]?[0-9]{3}/)
      zip_code.gsub!("-", "")
      @uri = URI.parse "http://www.cepfacil.com.br/service/?filiacao=#{token}&cep=#{zip_code}&formato=texto"
    else
      @uri = URI.parse "http://www.cepfacil.com.br/service/?filiacao=#{token}&cep=#{zip_code}&formato=texto"
    end
    
    http = Net::HTTP.new(@uri.host, @uri.port)
    call = Net::HTTP::Get.new(@uri.request_uri)
    
    response = http.request(call)
    response.body
    
    pattern = /^([a-z]+)\=/
    result = response.body.split("&")
    
    type = result[2].gsub!(pattern, "")
    state = result[3].gsub!(pattern, "")
    city = result[4].gsub!(pattern, "")
    neighborhood = result[5].gsub!(pattern, "")
    description = result[6].gsub!(pattern, "")
    
    address = {
      cep: zip_code,
      type: type,
      state: state,
      city: city,
      neighborhood: neighborhood,
      description: description
    }
  
  end
end
