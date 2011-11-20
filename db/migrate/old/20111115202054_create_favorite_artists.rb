class CreateFavoriteArtists < ActiveRecord::Migration
  def change
    create_table :favorite_artists do |t|
      t.integer :user_id
      t.integer :artist_id
      t.integer :play_count
      t.timestamps
    end
  end
end
