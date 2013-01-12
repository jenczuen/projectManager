class User < ActiveRecord::Base
  before_save :create_remember_token

  attr_accessible :firstName, :secondName, :description, :eMail, :password, :password_confirmation
  has_secure_password

  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true

  has_and_belongs_to_many :categories
  has_many :posts

  private
  
  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end
end
