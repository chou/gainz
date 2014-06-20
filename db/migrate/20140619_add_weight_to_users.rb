class AddWeightToUsers < ActiveRecord::Migration
  def change
    change_table(:users) do |t|
      t.integer :weight
    end
  end
end
