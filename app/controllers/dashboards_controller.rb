class DashboardsController < ApplicationController
  before_action :authenticate_user!, only: :show

  def show
    @activity_x = current_user.activity_x
    @age        = current_user.age
    @birthdate  = current_user.birthdate
    @first_name = current_user.first_name
    @last_name  = current_user.last_name
    @height     = current_user.height
    @id         = current_user.id
    @lean_mass  = current_user.lean_mass
    @weight     = current_user.weight
  end
end
