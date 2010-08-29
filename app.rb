# myapp.rb
require 'rubygems'
require 'sinatra'
require 'haml'
require 'logger'
require 'pp'

require 'helpers'

require 'lib/models'
require 'lib/last_fm'

#proxy = 'http://127.0.0.1:8118'
proxy = false

last_fm = LastFm.new('dfcca69a7d9650f940cb7983835caa4b')

get '/' do
  haml :index
end

post '/groups' do
  @lastfm_login = params[:last_fm_login]
  @top_artists = last_fm.top_artists(:user => @lastfm_login)

  haml :groups
end
