class SongPlay < ActiveRecord::Base
  belongs_to :song
  has_many :artist, :through => :song
  belongs_to :user
end
