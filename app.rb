require 'rubygems'
require 'sinatra/base'
require 'haml'
require 'logger'
require 'pp'
require 'date'

gem 'activesupport', '= 2.3.8'
require 'active_support'

require 'helpers'
require 'lib/models'
require 'lib/last_fm'

class NewAlbums < Sinatra::Base

  set :app_file, __FILE__
  set :root, File.dirname(__FILE__)
  set :static, true
  set :logging , true
  set :public, Proc.new { File.join(root, "public") }
  set :views, Proc.new { File.join(root, "views") }
  set :run, false
  set :dump_errors, true
  set :raise_errors, true 

  #PROXY = 'http://127.0.0.1:8118'
  PROXY = 'http://192.168.1.250:3128'
  LAST_FM_API_KEY = 'dfcca69a7d9650f940cb7983835caa4b'

  def self.production?
    ENV['RACK_ENV'] == 'production'
  end

  def self.proxy
    NewAlbums::PROXY unless self.production?
  end
  
  configure :development do

  end

  configure :production do

  end

  attr_accessor :last_fm
  
  def initialize
    @last_fm = LastFm.new(LAST_FM_API_KEY, self.class.proxy)
    super
  end

  helpers Sinatra::Partials
  helpers Sinatra::Logger

  get '/' do
    haml :index
  end

  post '/albums' do
    @lastfm_login = params[:last_fm_login].strip

    halt 'You should enter your login!' unless (@lastfm_login && !@lastfm_login.empty?)

    begin
      @top_artists = @last_fm.artists(:user => @lastfm_login, :limit => (params[:artists_limit].to_i))
    rescue LastFm::LastFmException => exc
      halt "An error occured: #{exc.message}"
    end

    @top_artists = @top_artists.map {|name| name.downcase}
    @top_artists.reject {|artist| artist.downcase.include?('various') && artist.downcase.include?('artists') }

    @recent_albums = []
    @upcoming_albums = []

    unless @top_artists.empty?
      @recent_albums = Album.by(@top_artists).recent.ordered_by_date
      @upcoming_albums = Album.by(@top_artists).upcoming.ordered_by_date
    end

    haml :albums
  end

end
