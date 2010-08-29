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