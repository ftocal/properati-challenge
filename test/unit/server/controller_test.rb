require "test/unit"
require "rack/test"

require './lib/actions/get_token'
require './lib/actions/get_url'
require './lib/server/controller'

class ControllerTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    getToken = Minitest::Mock.new
    getToken.expect(:execute,  "qwerty") do |url|
      if url == "http://www.google.com"
        true
      else
        raise ArgumentError
      end
    end
    
    getUrl =  Minitest::Mock.new
    getUrl.expect(:execute, "http://www.yahoo.com", ["asdfgh"])
    
    app = Controller.new(getToken, getUrl)
    builder = Rack::Builder.new
    builder.run app
  end

  def test_token_ok
    get '/token?url=http://www.google.com'
    assert_equal last_response.status, 200
  end

  def test_token_without_url
    get '/token'
    assert_equal last_response.status, 400
  end

  def test_token_with_url_without_protocol
    get '/token?url=www.yahoo.com.ar'
    assert_equal last_response.status, 400
  end

  def test_token_with_invalid_url
    get '/token?url=invalid-url'
    assert_equal last_response.status, 400
  end    

  def test_redirect_ok
    get '/redirect?token=asdfgh'
    assert_equal last_response.status, 302
  end

  def test_redirect_without_token
    get '/redirect'
    assert_equal last_response.status, 400
  end

end