require 'minitest/autorun'
require './lib/actions/get_url'
require './lib/data/repository'
require './lib/data/formatter'

class GetUrlActionTest < Minitest::Test
  def test_not_found
    repository = Repository.new
    formatter = Formatter.new
    getUrl = GetUrlAction.new(repository,formatter)
    url = getUrl.execute("123456")
    assert url == nil
  end
  def test_successfull
    token = "123456"
    savedUrl = "https://www.google.com"
    repository = Minitest::Mock.new
    repository.expect(:get, savedUrl , [token])
    formatter = Minitest::Mock.new
    formatter.expect(:parse, token , [token])
    getUrl = GetUrlAction.new(repository,formatter)
    url = getUrl.execute(token)
    assert url === savedUrl
  end  
end

