require 'rubygems'
require 'active_support'
require 'feedzirra'

class ITunes

  URL = "http://ax.itunes.apple.com/WebObjects/MZStore.woa/wpa/MRSS/newreleases/sf=143441/limit=500/explicit=true/rss.xml"

  FIELD_MAPPING = {
    :artist => 'itms:artist',
    :album => 'itms:album',
    :release_date => 'itms:releasedate',
    :cover_art_url => 'itms:coverArt'      
  }

  def recent_releases

    FIELD_MAPPING.each_pair {|accessor_name, field_name|
       Feedzirra::Feed.add_common_feed_entry_element(field_name, :as => accessor_name)
    }

    feed = Feedzirra::Feed.fetch_and_parse(URL)

    releases = feed.entries.map do |entry|
      {:artist => entry.artist,
       :album => entry.album,
       :release_date => Date.parse(entry.release_date),
       :cover_art_url => entry.cover_art_url.gsub('53x53-50', '100x100-75')}
    end

    releases

  end

end