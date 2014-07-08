class UsersController < ApplicationController
  before_filter :authorize_user, only: :update

  def update
    user = User.find(params[:id])
    set_template_vars(user)

    user.assign_attributes(user_params)
    if user.save
      set_template_vars(user)
      redirect_to dashboard_path
    else
      add_generic_error!
      render 'dashboards/show', status: :bad_request
    end
  end

  private
  def set_template_vars(user)
    @id         = user.id
    @height     = user.height
    @weight     = user.weight
    @birthdate  = user.birthdate
    @lean_mass  = user.lean_mass
    @activity_x = user.activity_x
    @first_name = user.first_name
    @last_name  = user.last_name
  end

  def user_params
    params.require(:user).permit(User::PERMITTED_PARAMS)
  end
end
