require 'dm-core'

DataMapper.setup(:default, ENV['DATABASE_URL'] || 'mysql://root:root@localhost/new_albums')


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