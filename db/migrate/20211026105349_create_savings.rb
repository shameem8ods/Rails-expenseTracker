class CreateSavings < ActiveRecord::Migration[5.2]
  def change
    create_table :savings do |t|
      t.string :saving_type
      t.float :amount
      t.date :date
      t.timestamps
    end
  end
end
