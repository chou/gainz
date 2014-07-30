class CreateUserPresenter < ActiveRecord::Migration
  def change
    create_table :user_presenters do |t|
      t.string :email
      t.string :first_name
      t.string :last_name
      t.string :birthdate
      t.decimal :weight
      t.decimal :height
      t.decimal :activity_x
      t.decimal :lean_mass
    end
  end
end
