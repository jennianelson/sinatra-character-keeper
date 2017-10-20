class Trait < ActiveRecord::Base
  has_many :character_traits
  has_many :characters, through: :character_traits
end
