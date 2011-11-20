class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.integer :artist_id
      t.text :title
      t.string :mbid, :limit => 36
    end
  end
end
