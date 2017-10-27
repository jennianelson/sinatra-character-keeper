class User < ActiveRecord::Base
  has_many :characters
  has_secure_password
  validates_presence_of :username, :email
  # validates :username, :email, uniqueness: true

  def slug
    username.downcase.gsub(" ", "-")
  end

  def self.find_by_slug(slug)
    self.all.detect {|s| slug == s.slug}
  end

end
