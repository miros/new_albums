require 'dm-core'


DataMapper::Logger.new('log/db.log', :debug)

DataMapper.setup(:default, ENV['DATABASE_URL'] || 'postgres:/postgres:postgres@localhost/new_albums')


class Artist

  include DataMapper::Resource

  property :id, Serial
  property :name, String, :length => 0..255, :index => true

  has n, :albums

end


class Album

  include DataMapper::Resource

  property :id, Serial
  property :name, String, :length => 0..255, :index => true
  property :release_date, Date

  belongs_to :artist

end

DataMapper.finalize