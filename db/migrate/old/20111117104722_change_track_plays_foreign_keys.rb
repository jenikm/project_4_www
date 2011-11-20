class ChangeTrackPlaysForeignKeys < ActiveRecord::Migration
  def up
    change_column :track_plays, :song_id, :string
    change_column :track_plays, :played_by_id, :string
  end

  def down
    change_column :track_plays, :song_id, :integer
    change_column :track_plays, :played_by_id, :integer
  end
end
