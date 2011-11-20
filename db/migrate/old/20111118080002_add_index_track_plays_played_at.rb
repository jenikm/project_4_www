class AddIndexTrackPlaysPlayedAt < ActiveRecord::Migration
  def up
    add_index :track_plays, :played_at
  end

  def down
    remove_index :track_plays, :column => :played_at
  end
end
