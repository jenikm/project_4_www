class Artist < ActiveRecord::Base
  has_many :songs
  has_many :users_artists
  has_many :users, :through => :users_artists
end
