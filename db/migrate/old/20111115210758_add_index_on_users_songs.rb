class AddIndexOnUsersSongs < ActiveRecord::Migration
  def up
    add_index :songs, :reference
    add_index :users, :reference
  end

  def down
    remove_index :users, :reference
    remove_index :songs, :reference
  end
end
