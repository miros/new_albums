class ReleasesCreator

  def create(releases)
    releases.each do |release|

      artist = Artist.first_or_create(:name => release[:artist])

      album = artist.albums.first(:name => release[:album]) ||
              artist.albums.new(:name => release[:album])

      album.release_date = release[:release_date]
      album.save
    end

  end


end