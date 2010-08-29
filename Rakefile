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
  require 'lib/metacritic'
  require 'lib/releases_creator'

  releases = Metacritic.new.upcoming_releases
  ReleasesCreator.new.create(releases)
end

task :cron => :scrap
