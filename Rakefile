require 'app'
require  'dm-migrations'


desc 'Migrate DataMapper database'
task :migrate do
  DataMapper.auto_migrate!
end

desc 'Update DataMapper database'
task :update do
  DataMapper.auto_update!
end


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

task :cron => :scrap
