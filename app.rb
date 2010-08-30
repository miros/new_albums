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
  @lastfm_login = params[:last_fm_login]
  @top_artists = last_fm.top_artists(:user => @lastfm_login)

  @top_artists = @top_artists.map {|name| name.downcase}

  @upcoming_albums = Album.all(:artist => Artist.all(:conditions => ["LOWER(name) in ?", @top_artists]),
                               :release_date.gt => Date.today,
                               :order => :release_date.asc)

  haml :groups
end
