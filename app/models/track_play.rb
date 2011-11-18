class TrackPlay < ActiveRecord::Base
  belongs_to :song, :foreign_key => :song_reference, :primary_key => :reference
  belongs_to :user, :foreign_key => :user_reference, :primary_key => :reference
end
