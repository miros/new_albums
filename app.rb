# myapp.rb
require 'rubygems'
require 'sinatra'
require 'haml'

require 'helpers'

get '/' do
  haml :index
end
