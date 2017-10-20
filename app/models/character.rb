class Character < ActiveRecord::Base
  belongs_to :user
  has_many :character_traits
  has_many :traits, through: :character_traits
end
