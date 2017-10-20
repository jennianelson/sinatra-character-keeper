class Character < ActiveRecord::Base
  belongs_to :user
  has_many :character_traits
  has_many :traits, through: :character_traits

  def slug
    username.downcase.gsub(" ", "-")
  end

  def self.find_by_slug(slug)
    self.all.detect {|s| slug == s.slug}
  end
  
end
