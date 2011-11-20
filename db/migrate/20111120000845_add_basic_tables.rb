class AddBasicTables < ActiveRecord::Migration
  def change
    create_table "artists", :id => false, :force => true do |t|
      t.integer "id",                 :null => false
      t.string  "mbid", :limit => 36
      t.text    "name"
    end

    create_table "users", :id => false, :force => true do |t|
      t.integer "id",                       :null => false
      t.string  "gender",     :limit => 1
      t.integer "age"
      t.string  "country",    :limit => 44
      t.date    "registered"
    end

    create_table "user_artists", :id => false, :force => true do |t|
      t.integer "user_id"
      t.integer "artist_id"
      t.integer "plays"
    end

    add_index "user_artists", ["artist_id"], :name => "user_artists_artist_id"
    add_index "user_artists", ["user_id"], :name => "user_artists_user_id"
  end

end
