class RenameForeignKeys < ActiveRecord::Migration
  def up
    rename_column :favorite_artists, :user_id, :user_reference
    rename_column :favorite_artists, :artist_id, :artist_reference

    rename_column :track_plays, :song_id, :song_reference
    rename_column :track_plays, :played_by_id, :user_reference
  end

  def down
    rename_column :track_plays, :user_reference, :played_by_id
    rename_column :track_plays, :song_reference, :song_id

    rename_column :favorite_artists, :artist_reference, :artist_id
    rename_column :favorite_artists, :user_reference, :user_id
  end
end
