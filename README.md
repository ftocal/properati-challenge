# properati-challenge

## Initialization
+ Install Ruby [version 2.3.1]
+ cd into this project's root directory
+ Run `gem install bundler` to install bundler
+ Run `bundle install` to install app dependencies

## Run application
+ Run `rackup -p 4567 config.ru` to start application
+ Access at <http://localhost:4567>

## Run test
+ Run `rake test` to run all tests

##  Endpoints

### Getting token

```GET /token?url=<url>```

Where:

* url: Url to save

Returns:

* [200] token associated with the saved url 
* [400] url empty or invalid
* [500] unexpected error 

### Redirect to url

```GET /redirect?token=<token>```

Where:

* token: Saved token

Returns:

* [301] redirect to the url associated with the token
* [400] token empty or invalid
* [404] token not found
* [500] unexpected error 
