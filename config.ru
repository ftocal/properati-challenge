require './lib/data/repository'
require './lib/data/formatter'
require './lib/actions/get_token'
require './lib/actions/get_url'
require './lib/server/controller'

formatter = Formatter.new
repository = Repository.new
getToken = GetTokenAction.new(repository,formatter)
getUrl = GetUrlAction.new(repository,formatter)
app = Controller.new(getToken, getUrl)

run app