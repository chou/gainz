class AddPrimaryStatsToUsers < ActiveRecord::Migration
  def change
    change_table(:users) do |t|
      t.decimal :activity_x
      t.decimal :lean_mass
    end
  end
end
