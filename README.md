# CepFacil

Ruby wrapper para o serviço em [cepfacil.com.br]

[![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/rodrigoalvesvieira/cep_facil)
[![Build Status](https://secure.travis-ci.org/rodrigoalvesvieira/cep_facil.png?branch=master)](http://travis-ci.org/rodrigoalvesvieira/cep_facil)

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

cep = "53417-540"

token = "1234567890"

address = CepFacil::API.new(cep, token)

### Acesso rápido via método de classe

address = CepFacil::API.get(cep, token) # Hash Notation => CepFacil::API.get(cep: cep, token: token)

# Argumentos como Hashes

address = CepFacil::API.new(cep: cep, token: token, format: "texto")

```

#### Retorna o endereço referente àquele CEP

O retorno é um objeto `CepFacil::API` que contem os seguintes métodos (propriedades) :

```ruby


address.cep # => "53417540"

address.type # => "Rua"

address.state # => "PE"

address.city # => "Paulista"

address.neighborhood # => "Artur Lundgren II"

address.street # => "Panelas"

# Também é possivel acessar utilizando metodos em português

address.tipo   # => "Avenida"

address.rua    # => "Francisco Navarro"

address.cidade # => "Varginha"

address.bairro # => "Centro"

address.estado # => "MG"

address.uf     # => "MG"

```

Embora isso deva parecer óbvio, informo que essas propriedades são todas **READONLY**.

Você pode checar se o endereço retornado é válido utilizando o método `valid?`:

```ruby

address = CepFacil::API.new "53020-140", token

address.valid? # true

```

Você também pode checar se o endereço foi encontrado com o CEP passado da seguinte forma:

```ruby

address = CepFacil::API.new "53417-540", token

address.found? # true

address = CepFacil::API.new "00000000", token

address.valid? # false

```

Adicionalmente, seu objeto `CepFacil::API` possui um método `full_format` e seu alias (`full_address`) que o descreve por extenso:

```ruby

address.full_format # => "Rua Panelas, Paulista - PE, Brasil"

address.full_address  # => Avenida Francisco Navarro, Varginha - MG, Brasil"  # Alias

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

* Rodrigo Alves - rodrigovieira1994@gmail.com - http://www.rodrigoalvesvieira.com

## Contribuidores

* Adriano Bacha - abacha@gmail.com
* Rafael Fidelis - rafa_fidelis@yahoo.com.br | http://defidelis.com

## Agradecimentos

Obrigado pelas pessoas que oferecem o serviço [CepFácil], sem o qual esse projeto não seria possível.

Obrigado também aos [Contribuidores] desse projeto.

## Doações

Se esse projeto é tão útil para você que lhe faz considerar fazer alguma doação, ao invés de me pagar uma cerveja
(o que seria um boa ideia, com certeza) considere doar para o [Khan Academy].

## Licença

CepFacil é liberado sob a [licença do MIT] com atribuições a Rodrigo Alves.

[0x]: https://github.com/rodrigoalvesvieira/cep_facil/tree/0x
[Geocoder]: https://github.com/alexreisner/geocoder
[CepFácil]: http://cepfacil.com.br
[cepfacil.com.br]: http://cepfacil.com.br
[Contribuidores]: #contribuidores
[licença do MIT]: http://pt.wikipedia.org/wiki/Licen%C3%A7a_MIT#Texto_da_licen.C3.A7a
[Khan Academy]: https://www.khanacademy.org/
