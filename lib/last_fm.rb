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
    requires_params [:user], params

    top_artists = request('user.getTopArtists', params)
    top_artists['topartists']['artist'].map {|artist| artist['name']}
  end


  def artists(params)
    requires_params [:user], params

    artists = []

    request_params = {:user => params[:user]}
    current_page_num = 0;

    loop do
      break if params[:limit] && artists.size >= params[:limit]

      current_page_num += 1

      info = request('library.getArtists', request_params.merge(:page => current_page_num))
      artists += info['artists']['artist'].map {|artist| artist['name']}

      pages_count = info['artists']['@attr']['totalPages'].to_i
      
      break if current_page_num >= pages_count
    end

    artists.slice(0..params[:limit]) if params[:limit]
  end

  private

    def requires_params(params_required, params_given)
      params_required.each {|param| throw Exception.new("no :#{param} param") unless params_given.has_key?(param) }
    end

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