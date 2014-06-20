class DashboardsController < ApplicationController
  before_action :authenticate_user!, only: :index

  def index
    @user = current_user
    # @first_name = current_user.first_name
    # @height     = current_user.height
    # @age        = current_user.age
    # @lean_mass   = current_user.lean_mass
    # @activity_x = current_user.activity_x
    # @weight     = current_user.weight
  end

end
