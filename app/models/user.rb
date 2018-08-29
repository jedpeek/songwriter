class User < ApplicationRecord
  validates :email, presence: true
  validates :email, uniqueness: true
  has_secure_password

  def self.find_or_create_by_omniauth(auth_hash)
    oauth_email = auth_hash["info"]["email"]
    oauth_username = auth_hash['info']['nickname']
    #first_or_create will always return an instance of a user
    where(email: oauth_email).first_or_create do |user|
      user.email = oauth_email
      user.username = oauth_username
      user.password = SecureRandom.hex(10)
    end
  end

end
