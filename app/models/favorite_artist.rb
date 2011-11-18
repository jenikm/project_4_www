class FavoriteArtist < ActiveRecord::Base
  belongs_to :user, :foreign_key => :user_reference, :primary_key => :reference
  belongs_to :artist, :foreign_key => :artist_reference, :primary_key => :reference
end
