# myapp.rb
require 'rubygems'
require 'sinatra'
require 'haml'
require 'logger'
require 'pp'
require 'date'

require 'helpers'

require 'lib/models'
require 'lib/last_fm'

if ENV['RACK_ENV'] == 'production'
  proxy = nil
else
  proxy = 'http://127.0.0.1:8118'
end

last_fm = LastFm.new('dfcca69a7d9650f940cb7983835caa4b', proxy)

get '/' do
  haml :index
end

post '/groups' do
  @lastfm_login = params[:last_fm_login].strip

  halt 'You should enter your login!' unless (@lastfm_login && !@lastfm_login.empty?)

  @top_artists = last_fm.artists(:user => @lastfm_login, :limit => (params[:artists_limit].to_i))
  @top_artists = @top_artists.map {|name| name.downcase}

  @upcoming_albums = []
  @upcoming_albums = Album.by(@top_artists).upcoming.ordered_by_date unless @top_artists.empty?

  haml :groups
end
