class UsersController < ApplicationController
  before_filter :reject_unauthorized_actions
  before_filter :configure_permitted_parameters

  def update
    user = current_user
    set_template_vars
    params['user'].delete('id')
    account_update_params = prep_params

    if user.update_without_password(account_update_params)
      set_template_vars
      redirect_to dashboard_path
    else
      add_generic_error!
      render 'dashboards/show', status: :bad_request
    end
  end

  private
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:account_update) do |u|
      u.permit(:password, :password_confirmation, *User::PERMITTED_PARAMS)
    end
  end

  def prep_params
    sanitized_params = user_params

    if sanitized_params[:password].blank?
      sanitized_params.delete(:password)
      sanitized_params.delete(:password_confirmation)
    end

    sanitized_params
  end

  def set_template_vars
    @id         = current_user.id
    @height     = current_user.height
    @weight     = current_user.weight
    @birthdate  = current_user.birthdate
    @lean_mass  = current_user.lean_mass
    @activity_x = current_user.activity_x
    @first_name = current_user.first_name
    @last_name  = current_user.last_name
  end

  def user_params
    devise_parameter_sanitizer.sanitize(:account_update)
  end
end
