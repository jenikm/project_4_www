class Song < ActiveRecord::Base
  belongs_to :artist
  has_many :track_plays, :foreign_key => :song_reference, :primary_key => :reference
  has_many :users, :through => :track_plays

end
