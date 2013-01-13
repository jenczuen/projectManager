class ChangeEMailNameInUser < ActiveRecord::Migration
  def change
    remove_index :users, :eMail
    remove_column :users, :eMail
    add_column :users, :email, :string
    add_index :users, :email, unique: true
  end
end
