# CepFacil

Ruby wrapper para o serviço em cepfacil.com.br

## Instalação

NOTA: Esse projeto encontra-se na versão 1.x, cuja API difere completamente das versões 0.x. Se você está procurando a versão mais antiga, veja a branch [0x], que se mantém intacta.

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

```

#### Retorna o endereço referente àquele CEP

O retorno é um objeto `CepFacil::API` que contem 6 métodos (propriedades): cep, type, state, city, neighborhood, street. Assim você os acessa:

```ruby

address.cep # => "53417540"

address.type # => "Rua"

address.state # => "PE"

address.city # => "Paulista"

address.neighborhood # => "Artur Lundgren II"

address.street # => "Panelas"

```

Embora isso deva parecer óbvio, informo que essas propriedades são todas **READONLY**.

Adicionalmente, seu objeto `CepFacil::API` possui um método `full` que o descreve por extenso:

```ruby

address.full_format # => "Rua Panelas, Paulista - PE, Brasil"

```

Existem três formatos possíveis para se armazenar CEPs:

```ruby
"12345-678"
"12345678"
12345678   # Eu realmente não usaria esse
```

CepFacil funciona com esses três formatos.

## Integração com a gem Geocoder

A gem [Geocoder] é ótima para uso e manipulação de dados geográficos em projetos Ruby. Para integrá-la com o CepFacil, faça assim:

```ruby

geocoded_by address.full_format

```

## Autor

* Rodrigo Alves Vieira - rodrigovieira1994@gmail.com - http://www.rodrigoalvesvieira.com

## Contribuidores

* Adriano Bacha - abacha@gmail.com

## Agradecimentos

Obrigado pelas pessoas que oferecem o serviço [CepFácil], sem o qual esse projeto não seria possível.

Obrigado também aos [Contribuidores] desse projeto.

## Licença

CepFacil é liberado sob a [licença do MIT] com atribuições a Rodrigo Alves Vieira.

[0x]: https://github.com/rodrigoalvesvieira/cep_facil/tree/0x
[Geocoder]: https://github.com/alexreisner/geocoder
[CepFácil]: http://cepfacil.com.br
[Contribuidores]: #contribuidores
[licença do MIT]: http://pt.wikipedia.org/wiki/Licen%C3%A7a_MIT#Texto_da_licen.C3.A7a
