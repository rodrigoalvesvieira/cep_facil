CepFácil
===========

Wrapper Ruby for the service at cepfacil.com.br

Installation
------------

In the `Gemfile`

```ruby

gem `cep_facil`

```

Or via RubyGems, directly:

  gem install cep_facil
  

Usage
-----

```ruby
require "cep_facil"
cep = "5417-540"
token = "1234567890" # get yours at cepfacil.com.br
result = CepFacil.get_address(cep, token)
# Returns the address referent to that zip code.
result[:city]
# Returns the city referent to that zip code.
```

The response is a Hash object that contains 6 keys: cep, type, state, city, neighborhood, description.

There are three formats for one to store Brazilian zip codes (CEPS):

* "12345-678"
* "12345678"
* 12345678 # Don't use this one, really.

CepFácil works with the three of them.

AUTHOR
------

* Rodrigo Vieira - rodrigovieira1994@gmail.com - http://www.rodrigoalvesvieira.com

LICENCE
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