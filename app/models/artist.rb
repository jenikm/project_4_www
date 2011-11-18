class Artist < ActiveRecord::Base
  has_many :songs
  has_many :favorite_artists, :primary_key => :reference, :foreign_key => :artist_reference
  has_many :users, :through => :favorite_artists
end
