class UsersController < ApplicationController
  def update
    user = User.find(params[:id])
    set_template_vars(user)

    if current_user_authorized?
      user.assign_attributes(user_params)
      if user.save
        set_template_vars(user)
        redirect_to dashboards_path
      else
        add_generic_error!
        render 'dashboards/index', status: :bad_request
      end
    else
      add_generic_error!
      render 'dashboards/index', status: :unauthorized
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
