class CreateCategoryUserJoinTable < ActiveRecord::Migration
  def change
    create_table :categories_users, :id => false do |t|
      t.integer :user_id
      t.integer :category_id
    end
  end
end
