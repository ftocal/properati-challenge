require 'minitest/autorun'
require './lib/actions/get_token'
require './lib/data/repository'
require './lib/data/formatter'

class GetTokenActionTest < Minitest::Test
  def test_successfull
    repository = Repository.new
    formatter = Formatter.new
    getToken = GetTokenAction.new(repository,formatter)
    token = getToken.execute("http://www.google.com.ar")
    assert token != nil
    assert token.length == 6
  end
  def test_invalid_url
    repository = Repository.new
    formatter = Formatter.new
    getToken = GetTokenAction.new(repository,formatter)
    assert_raises ArgumentError do
      getToken.execute("url_invalid")
    end
  end

end

