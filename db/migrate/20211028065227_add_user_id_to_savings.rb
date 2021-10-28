class AddUserIdToSavings < ActiveRecord::Migration[5.2]
  def change
    add_column :savings, :user_id, :integer
    add_index :savings, :user_id
  end
end
