class User < ActiveRecord::Base
  has_many :countries
  has_many :favorite_artists, :primary_key => :reference, :foreign_key => :user_reference
  has_many :track_plays, :primary_key => :reference, :foreign_key => :user_reference
  has_one :country
  has_many :artists, :through => :favorite_artists

  MALE   = 0.freeze
  FEMALE = 1.freeze

  def self.gender_to_index(gender)
    return gender.to_i if %w(0 1).include?(gender.to_s)
    return gender.downcase == 'm' ? 0 : 1
  end

  def gender_char
    self.gender == MALE ? "m" : "f"
  end
end
