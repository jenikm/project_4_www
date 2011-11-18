class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.string :name
      t.string :reference
      t.integer :artist_id
    end
  end
end
