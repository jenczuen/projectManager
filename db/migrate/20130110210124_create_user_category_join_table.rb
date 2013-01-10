class CreateUserCategoryJoinTable < ActiveRecord::Migration
  def change
    create_table :users_categories, :id => false do |t|
      t.integer :user_id
      t.integer :category_id
    end
  end
end
