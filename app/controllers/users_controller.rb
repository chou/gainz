class UsersController < ApplicationController
  def update
    user = User.find(params[:id])
    user.assign_attributes(user_params)
    if user.save
      redirect_to dashboards_path
    else
      render_template 'dashboards/index'
    end
  end

  private
  def user_params
    params.require(:user).permit(User::PERMITTED_PARAMS)
  end
end
