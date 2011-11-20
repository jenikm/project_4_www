class AddIndexesToTrackPlays < ActiveRecord::Migration
  def up
    add_index :track_plays, :user_reference
    add_index :track_plays, :song_reference
    add_index :favorite_artists, :user_reference
    add_index :favorite_artists, :artist_reference
  end

  def down
    remove_index :favorite_artists, :column => :artist_reference
    remove_index :favorite_artists, :column => :user_reference
    remove_index :track_plays, :column => :song_reference
    remove_index :track_plays, :column => :user_reference
  end
end
