class CreateFoodRecordStat < ActiveRecord::Migration
  def change
    create_table :food_record_stats do |t|
      t.integer :amount
      t.integer :calories
      t.integer :carb
      t.integer :cholesterol
      t.integer :fiber
      t.string  :name
      t.integer :protein
      t.integer :sat_fat
      t.integer :sodium
      t.integer :sugar
      t.integer :tot_fat
      t.string :units
      t.integer :trans_fat
    end
  end
end
