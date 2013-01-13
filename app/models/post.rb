class Post < ActiveRecord::Base
  attr_accessible :title, :content

  belongs_to :user
  belongs_to :category
  
  validates :title, presence: true
  validates :content, presence: true
end
