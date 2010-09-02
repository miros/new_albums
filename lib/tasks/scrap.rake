task :scrap do
  puts 'Scraping started'

  require 'lib/metacritic'
  require 'lib/i_tunes'
  require 'lib/releases_creator'

  puts 'Scraping Metacritic'
  releases = Metacritic.new.upcoming_releases
  ReleasesCreator.new.create(releases)

  puts 'Scraping ITunes'
  releases = ITunes.new.recent_releases
  ReleasesCreator.new.create(releases)

  puts 'Scraping finished'

end