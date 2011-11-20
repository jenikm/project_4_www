class CreateTrackPlays < ActiveRecord::Migration
  def change
    create_table :track_plays do |t|
      t.timestamp :played_at
      t.integer :song_id
      t.integer :played_by_id
    end
  end
end
