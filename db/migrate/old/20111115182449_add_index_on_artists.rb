class AddIndexOnArtists < ActiveRecord::Migration
  def up
    add_index :artists, :reference
  end

  def down
    remove_index :artists, :reference
  end
end
