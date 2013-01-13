class User < ActiveRecord::Base
  attr_accessible :firstName, :secondName, :description, :eMail, :password, :password_confirmation
  has_secure_password

  has_and_belongs_to_many :categories
  has_many :posts

  before_save :create_remember_token
  before_save { |user| user.email = email.downcase }

  validates :firstName, presence: true
  validates :secondName, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, 
            presence: true, 
            uniqueness: { case_sensitive: false}, 
            format: { with: VALID_EMAIL_REGEX }
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true

  private
  
  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end
end
