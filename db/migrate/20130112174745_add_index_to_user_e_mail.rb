class AddIndexToUserEMail < ActiveRecord::Migration
  def change
    add_index :users, :eMail, unique: true
  end
end
