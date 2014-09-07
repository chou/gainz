class CreateFoodRecords < ActiveRecord::Migration
  def change
    create_table :food_records do |t|
      t.string :name
      t.integer :quantity
      t.string :units
      t.date  :date
      t.integer :user_id
      t.integer :food_record_stats_id
    end
  end
end
