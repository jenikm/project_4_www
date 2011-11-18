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

ActiveRecord::Schema.define(:version => 20111118080002) do

  create_table "artists", :force => true do |t|
    t.string "name"
    t.string "reference"
  end

  add_index "artists", ["reference"], :name => "index_artists_on_reference"

  create_table "countries", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "favorite_artists", :force => true do |t|
    t.string   "user_reference"
    t.string   "artist_reference"
    t.integer  "play_count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "favorite_artists", ["artist_reference"], :name => "index_favorite_artists_on_artist_reference"
  add_index "favorite_artists", ["user_reference"], :name => "index_favorite_artists_on_user_reference"

  create_table "searches", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "songs", :force => true do |t|
    t.string  "name"
    t.string  "reference"
    t.integer "artist_id"
  end

  add_index "songs", ["reference"], :name => "index_songs_on_reference"

  create_table "track_plays", :force => true do |t|
    t.datetime "played_at"
    t.string   "song_reference"
    t.string   "user_reference"
  end

  add_index "track_plays", ["played_at"], :name => "index_track_plays_on_played_at"
  add_index "track_plays", ["song_reference"], :name => "index_track_plays_on_song_reference"
  add_index "track_plays", ["user_reference"], :name => "index_track_plays_on_user_reference"

  create_table "users", :force => true do |t|
    t.string  "name"
    t.string  "reference"
    t.integer "gender"
    t.integer "age"
    t.integer "country_id"
    t.date    "registered_at"
  end

  add_index "users", ["country_id"], :name => "index_users_on_country_id"
  add_index "users", ["reference"], :name => "index_users_on_reference"

end
