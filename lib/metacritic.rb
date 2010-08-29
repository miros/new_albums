require "date"
require "rubygems"
require "nokogiri"
require "open-uri"

class Metacritic

  URL = 'http://features.metacritic.com/features/upcoming-album-release-calendar/'

  def upcoming_releases

    html = get_html
    upcoming_page = Nokogiri::HTML(html)

    releases = [];

    current_releases_date = nil;

    upcoming_page.css('table.listtable')[0].css('tr').each do |tr|
      if (th = tr.at_css('th'))
        current_releases_date = Date.parse(th.content)
      else
        release = {:release_date => current_releases_date}

        release[:artist] = tr.css('td')[0].content
        release[:album] =  tr.css('td')[1].content

        releases << release;
      end
    end

    releases

  end

  private

    def get_html
      params = {}
      open(URL, params).read
    end

end