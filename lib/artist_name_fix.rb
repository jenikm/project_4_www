module ArtistNameFix
  def self.artist_name_fix
    s = IO.read(File.join(Rails.root, "lib", "artist_name_fix.sql"))
    while line = s.gets
      ActiveRecord::Base.connection.execute line
    end
  end
end
