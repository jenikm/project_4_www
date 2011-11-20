# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20111120005105) do

  create_table "artists", :id => false, :force => true do |t|
    t.integer "id",                 :null => false
    t.string  "mbid", :limit => 36
    t.text    "name"
  end

  add_index "artists", ["mbid"], :name => "index_artists_on_mbid"
  add_index "artists", ["name"], :name => "index_artists_on_name"

  create_table "song_plays", :force => true do |t|
    t.datetime "played_at"
    t.integer  "pseudo_user_reference"
    t.integer  "song_id"
  end

  create_table "songs", :force => true do |t|
    t.integer "artist_id"
    t.text    "title"
    t.string  "mbid",      :limit => 36
  end

  add_index "songs", ["mbid"], :name => "index_songs_on_mbid"
  add_index "songs", ["title"], :name => "index_songs_on_title"

  create_table "user_artists", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "artist_id"
    t.integer "plays"
  end

  add_index "user_artists", ["artist_id"], :name => "user_artists_artist_id"
  add_index "user_artists", ["user_id"], :name => "user_artists_user_id"

  create_table "users", :id => false, :force => true do |t|
    t.integer "id",                       :null => false
    t.string  "gender",     :limit => 1
    t.integer "age"
    t.string  "country",    :limit => 44
    t.date    "registered"
  end

  add_index "users", ["age"], :name => "index_users_on_age"

end
