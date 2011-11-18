class ChangeFavoriteArtistsForeignKey < ActiveRecord::Migration
  def up
    change_column :favorite_artists, :user_id, :string
    change_column :favorite_artists, :artist_id, :string
  end

  def down
    change_column :favorite_artists, :user_id, :integer
    change_column :favorite_artists, :artist_id, :integer
  end
end
