class CreateSongPlays < ActiveRecord::Migration
  def change
    create_table :song_plays do |t|
      t.datetime :played_at
      t.integer :pseudo_user_reference
      t.integer :song_id
    end
  end
end
