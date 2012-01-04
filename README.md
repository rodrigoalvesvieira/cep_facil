CepFácil
===========

Wrapper Ruby for the service at cepfacil.com.br

Installation
------------

In the `Gemfile`

```ruby
gem "cep_facil"
```

Or via RubyGems, directly:

  `gem install cep_facil`
  
CepFacil works only in Ruby 1.9.2 by default. If you need it to work with 1.8.7
and JRuby, for example, you must do the following:

In the `Gemfile`

```ruby
gem "cep_facil", :git => "git://github.com/rodrigoalvesvieira/cep_facil.git", :branch => "1.8.7"
```

Usage
-----
  
### Fetching an address by zip code

```ruby
require "cep_facil"
cep = "53417-540"
token = "1234567890" # get yours at cepfacil.com.br
address = CepFacil.get_address(cep, token)
# Returns the address referent to that zip code.
address[:city]
# Returns the city referent to that zip code.
```

Alternatively, you can do:

```ruby
require "cep_facil"
include CepFacil
address = get_address cep, token
```

The response is a Hash object that contains 6 keys: cep, type, state, city, neighborhood, description.

There are three formats for one to store Brazilian zip codes (CEPs):

```ruby
"12345-678"
"12345678"
12345678   # I wouldn't use this one, really.
```

CepFácil works with the three of them.

### Displaying an address in full mode

```ruby
address = CepFacil.get_address(cep, token)
CepFacil.full address
```

Or:

````ruby
require "cep_facil"
include CepFacil

address = get_address("50050-000", token)
full(address) # => Rua da Aurora, Boa Vista, Recife-PE, Brasil.
```

Author
------

* Rodrigo Vieira - rodrigovieira1994@gmail.com - http://www.rodrigoalvesvieira.com

Thanks
-------

Huge thanks and cheers to CépFácil (http://cepfacil.com.br) of course. Thanks for the great service that you provide!

Licence
-------

Copyright (c) 2012 Rodrigo Vieira. http://www.rodrigoalvesvieira.com/

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to use, copy and modify copies of the Software, subject 
to the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.