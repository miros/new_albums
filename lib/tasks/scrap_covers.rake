task 'scrap:covers' do
  puts 'Scraping cover art started'

  require 'lib/cover_art_scraper'

  last_fm = LastFm.new(NewAlbums::LAST_FM_API_KEY, NewAlbums.proxy)
  CoverArtScraper.new(last_fm).scrap_covers

  puts 'Scraping finished'
end