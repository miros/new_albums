require 'dm-core'

DataMapper::Logger.new('log/db.log', :debug)

db_url = 'postgres://postgres:postgres@localhost/new_albums'
DataMapper.setup(:default, ENV['DATABASE_URL'] || db_url)

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

  def self.by(artists)
    all(:artist => Artist.all(:conditions => ["LOWER(name) in ?", artists]))
  end

  def self.upcoming()
    all(:release_date.gt => Date.today)
  end

  def self.ordered_by_date()
    all(:order => :release_date.asc)
  end

end

DataMapper.finalize