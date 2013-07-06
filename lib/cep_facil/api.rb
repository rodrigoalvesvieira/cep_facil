#--
# Copyright (c) 2012-2013 Rodrigo Alves
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#++

require "net/http"
require "json"

module CepFacil
  class Address
    attr_accessor :zip_code, :type, :city, :state, :neighborhood, :street

    def initialize(zip_code, type, city, state, neighborhood, street)
      @zip_code = zip_code
      @type = type
      @city = city
      @state = state
      @neighborhood = neighborhood
      @street = street
    end

    def valid?
      answ = false
      answ = true if (self.zip_code && type && city)
      return true
    end

    # Returns the address in its extense format
    def full_format
      "#{self.type} #{self.street}, #{self.city} - #{self.state} #{self.zip_code}, Brasil"
    end
  end

  class API
    attr_accessor :token

    BASE_URL = "http://www.cepfacil.com.br/service/?filiacao=%s&cep=%s&formato=json"
    PLACEHOLDER_METHODS = {
      estado: :uf,
      type: :tipo,
      state: :uf,
      city: :cidade,
      neighborhood: :bairro,
      street: :descricao,
      rua: :descricao
    }

    class << self
      # Removes all non-numeric caracters from the zip_code argument
      # and limit it to 8 caracters
      def parse_zip_code(zip_code)
        return zip_code.to_s.gsub(/([^0-9]+)/,"")[0...8]
      end
    end

    def initialize(token)
      @token = token
    end

    def get_address(zip_code)
      uri = URI(BASE_URL % [self.token, CepFacil::API.parse_zip_code(zip_code)])
      content = Net::HTTP.get(uri)

      result = JSON.parse content

      address = CepFacil::Address.new(
        result["CEP"], result["LogradouroTipo"],
        result["Cidade"], result["UF"], result["Bairro"], result["Logradouro"])
    end

  end
end