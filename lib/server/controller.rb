require "sinatra/base"
require 'sinatra/param'
require 'json'

class Controller < Sinatra::Base
  helpers Sinatra::Param

  def initialize(getTokenAction, getUrlAction)
    super(nil)
    @getTokenAction = getTokenAction
    @getUrlAction = getUrlAction
  end
  
  get '/token' do
    param :url, String, required: true
    url = params[:url]
    token = @getTokenAction.execute(url)
    { token: token }.to_json
  end

  get '/redirect' do
    param :token, String, required: true
    token = params[:token]
    url = @getUrlAction.execute(token)
    status 301
    redirect to(url)
  end
end