module ArtistNameFix
  def self.artist_name_fix
    s = File.open(File.join(Rails.root, "lib", "artist_name_fix.sql"), "r")
    while line = s.gets
      ActiveRecord::Base.connection.execute line
    end
  end
end
