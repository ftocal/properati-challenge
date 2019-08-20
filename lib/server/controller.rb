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
    begin
      param :url, String, required: true
      url = params[:url]
      token = @getTokenAction.execute(url)
      content_type :json
      status 200
      { token: token }.to_json
    rescue ArgumentError => e
      content_type :json
      status 400
      {:result => 'error', :message => e.message}.to_json
    rescue => e
      content_type :json
      status 500
      {:result => 'error', :message => e.message}.to_json      
    end
  end

  get '/redirect' do
    begin
      param :token, String, required: true
      token = params[:token]
      url = @getUrlAction.execute(token)
      if url == nil
        content_type :json
        status 404
        {:result => 'error', :message => 'Token not found'}.to_json
      else
        status 301
        redirect to(url)
      end
    rescue ArgumentError => e
      content_type :json
      status 400
      {:result => 'error', :message => e.message}.to_json
    rescue => e
      content_type :json
      status 500
      {:result => 'error', :message => e.message}.to_json
    end
  end
end
