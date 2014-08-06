class AddGoalToUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.string :goal
    end
  end
end
