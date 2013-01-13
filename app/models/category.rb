class Category < ActiveRecord::Base
  attr_accessible :name, :description

  validates :name, presence: true
  validates :description, presence: true

  has_and_belongs_to_many :users
  has_many :posts
end
