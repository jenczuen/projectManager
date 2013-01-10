class User < ActiveRecord::Base
  attr_accessible :firstName, :secondName, :description, :eMail

  has_and_belongs_to_many :categories
end
