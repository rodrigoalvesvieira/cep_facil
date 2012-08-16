# encoding: utf-8
require "net/http"

module CepFacil
  class API
    attr_reader :read
    
    BASE_URL = "http://www.cepfacil.com.br/service/?filiacao=%s&cep=%s&formato=%s"
    METHODS_PLACEHOLDER = {estado: :uf , type: :tipo , state: :uf , city: :cidade , neighborhood: :bairro , street: :descricao , rua: :descricao}
    
    class << self
      ##
      # Removes all non-numeric caracters and limit to 8 caracters
      def parse_zip_code(zip_code)
        return zip_code.to_s.gsub(/([^0-9]+)/,"")[0...8]   
      end
    end
    
    def initialize(*args)
      args = (args[0].is_a?(Hash) ? args[0] : Hash[[:cep,:token,:format].zip(args)])
      args[:format] ||= "texto"
      args[:cep] = CepFacil::API.parse_zip_code(args[:cep])

      uri = URI(BASE_URL % [args[:token], args[:cep], args[:format]])      
      @read = Net::HTTP.get(uri)
      @data = args[:format].to_s == "texto" ? Hash[@read.split("&").map { |i| i.split("=") } ] : @read    
      
      # OPTIMIZE: Need a better implementation
      return self
    end
    
    ##
    # Returns true if the address in question is a valid one
    # returns false otherwise
    def valid?
      @data.is_a?(Hash) and @data.size > 1
    end
    
    #
    # Returns the address in its extense format
    def full_format
      "#{type} #{street}, #{city} - #{state}, Brasil"
    end
    
    def self.get(*args)
      self.new(*args)
    end
    
    private
    #
    # Define placeholder methods for the address attributes
    # in portuguese
    def method_missing(*args)
      return (@data[METHODS_PLACEHOLDER[args[0].to_sym].to_s] || @data[args[0].to_s]).force_encoding(Encoding::UTF_8) || super(*args) 
    end
    
    alias :address :full_format
  end
end