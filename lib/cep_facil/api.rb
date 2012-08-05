require "cgi"
require "net/http"

module CepFacil
  class API
    attr_reader :cep, :type, :state, :city, :neighborhood, :street

    def initialize(cep, token)
      @cep = cep
      @token = token

      zip_code = @cep.to_s

      if zip_code.match(/^[0-9]{5}[-]?[0-9]{3}/)
        zip_code.gsub!("-", "")
        @uri = URI.parse "http://www.cepfacil.com.br/service/?filiacao=#{token}&cep=#{zip_code}&formato=texto"
      else
        @uri = URI.parse "http://www.cepfacil.com.br/service/?filiacao=#{token}&cep=#{zip_code}&formato=texto"
      end

      http = Net::HTTP.new(@uri.host, @uri.port)
      call = Net::HTTP::Get.new(@uri.request_uri)

      response = http.request(call)

      pattern = /^([a-z]+)\=/

      result = response.body.split("&")

      # TODO: Document everything
      # TODO: Implement fallback for when CEP is non-existent/invalid.

      @type = result[2].gsub!(pattern, "")
      @state = result[3].gsub!(pattern, "")
      @city = result[4].gsub!(pattern, "")
      @neighborhood = result[5].gsub!(pattern, "")
      @street = result[6].gsub!(pattern, "")
    end

    def full_format
      "#{self.type} #{self.street}, #{self.city} - #{self.state}, Brasil"
    end
  end
end
