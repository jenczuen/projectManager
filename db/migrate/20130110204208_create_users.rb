class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer id
      t.string firstName
      t.string secondName
      t.string description
      t.string eMail
      
      t.timestamps
    end
  end
end
