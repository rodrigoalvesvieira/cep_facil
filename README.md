# CepFacil

Wrapper Ruby para a API do [CepFácil]

[![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/rodrigoalvesvieira/cep_facil)
[![Build Status](https://secure.travis-ci.org/rodrigoalvesvieira/cep_facil.png?branch=master)](http://travis-ci.org/rodrigoalvesvieira/cep_facil)
* [![Dependencies](https://gemnasium.com/rodrigoalvesvieira/cepfacil.png?travis)](https://gemnasium.com/rodrigoalvesvieira/cepfacil)

## Instalação

**NOTA:** Esse projeto encontra-se na versão 1.x, cuja API difere completamente das versões 0.x. Se você está procurando a versão mais antiga, veja a branch [0x], que se mantém intacta.

No `Gemfile`:

```ruby
gem "cep_facil"
```

Ou via RubyGems, diretamente:

  `$ gem install cep_facil`

## Uso

### Obtendo um endereço pelo CEP

Para usar a API do [CepFácil], você precisa obter um token do serviço. Você obtém esse token gratuitamente em cepfacil.com.br

```ruby
require "cep_facil"

# Autenticando

token = "1234567890"
conn = CepFacil::API.new token

# Obtendo endereços

zip_code = "53416540"
address = conn.get_address(zip_code)
```

#### Retorna o endereço (objeto `CepFacil::Address`) referente àquele CEP


```ruby
address.cep # => "53417540"

address.type # => "Rua"

address.state # => "PE"

address.city # => "Paulista"

address.neighborhood # => "Artur Lundgren II"

address.street # => "Panelas"
```

Embora isso deva parecer óbvio, informo que essas propriedades são todas **READONLY**.
Você pode checar se o endereço retornado é válido utilizando o método `valid?`:

```ruby

address.valid? # true
```

Adicionalmente, seu objeto `CepFacil::Address` possui um método `full_format` que o descreve por extenso:

```ruby
address.full_format # => "RUA PANELAS, PAULISTA - PE 53416540, Brasil"
```

Você pode passar o CEP como uma string qualquer, letras, caracteres especiais (pontos, hífens) são removidos automaticamente.

```ruby
"12345-678"
"123.45.678"
"123-456.78"
"12345678"
12345678   # Não recomendado, prefira utilizar Strings
```

## Integração com a gem Geocoder

A gem [Geocoder] é ótima para uso e manipulação de dados geográficos em projetos Ruby. Para integrá-la com o CepFacil, faça assim:

```ruby
geocoded_by address.full_format
```

## Autor

* Rodrigo Alves

## Contribuidores

* Adriano Bacha
* Rafael Fidelis

## Agradecimentos

Obrigado pelas pessoas que oferecem o serviço [CepFácil], sem o qual esse projeto não seria possível.

Obrigado também aos [Contribuidores] desse projeto.

## Licença

CepFacil é liberado sob a [licença do MIT] com atribuições a Rodrigo Alves. Para detalhes veja o arquivo LICENSE.txt

[0x]: https://github.com/rodrigoalvesvieira/cep_facil/tree/0x
[Geocoder]: https://github.com/alexreisner/geocoder
[CepFácil]: http://cepfacil.com.br
[cepfacil.com.br]: http://cepfacil.com.br
[Contribuidores]: #contribuidores
[licença do MIT]: http://pt.wikipedia.org/wiki/Licen%C3%A7a_MIT#Texto_da_licen.C3.A7a