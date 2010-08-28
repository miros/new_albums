require 'rubygems'
require 'net/http'
require 'cgi'
require 'uri'
require 'pp'
require 'json'

class LastFm

  def initialize(api_key, proxy = nil)
    @api_key = api_key
    @proxy = proxy
  end

  API_URL = "http://ws.audioscrobbler.com/2.0/"

  def top_artists(params)
    throw Exception.new('no :user param') unless params[:user]
    request('user.getTopArtists', :user => params[:user])
  end

  private

    def request(method_name, params)
      params ||= []
      params[:method] = method_name
      params[:api_key] = @api_key
      params[:format] = 'json'

      api_url = URI.parse(API_URL)
      response = http_get(api_url.host, api_url.path, params)
      JSON.parse(response);
    end


    def http_get(domain, path, params)

      http = if @proxy
        proxy_uri = URI.parse(@proxy)
        Net::HTTP::Proxy(proxy_uri.host, proxy_uri.port);
      else
        Net::HTTP
      end
     
      return http.get(domain, "#{path}?".concat(params.collect { |k,v| "#{k}=#{CGI::escape(v.to_s)}" }.reverse.join('&'))) unless params.nil?
      return http.get(domain, path)
    end

end