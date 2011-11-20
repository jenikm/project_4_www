class AddIndexes < ActiveRecord::Migration
  def change
    add_index :artists, :mbid
    add_index :artists, :name
    add_index :songs, :mbid
    add_index :songs, :title
    add_index :users, :age
  end

end
