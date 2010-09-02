class CoverArtScraper

  def initialize(last_fm)
    @last_fm = last_fm
  end

  def scrap_covers
    Album.without_covers.each do |album|
      cover_art = get_cover_art_url(album)
      puts "Cover art found for #{album.artist.name} - #{album.name}! updating..." if cover_art
      album.update(:cover_art_url => cover_art) if cover_art
    end
  end

  private

    def get_cover_art_url(album)
      info = @last_fm.album_info(:artist => album.artist.name, :album => album.name)
      info[:cover_art] if info
    rescue Exception => exc
      puts exc      
    end

end