class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  GENERIC_ERROR_MSG = 'Something went wrong; please try again.'.freeze

  def add_generic_error!
    flash[:error] = GENERIC_ERROR_MSG
  end

  def after_sign_in_path_for(_resource)
    dashboard_path
  end

  def reject_unauthorized_actions
    require_session
    redirect_to new_user_session_path unless current_user_authorized?
  end

  def current_user_authorized?
    false unless current_user

    if params[:user]
      params[:user]['id'].to_i == current_user.id
    else
      flash[:error] = 'Missing user params'
      false
    end
  end

  def require_session
    redirect_to new_user_session_path unless current_user
  end

  def verify_ownership
    if current_user.id != params[:user_id].to_i
      flash[:error] = 'Not authorized'
      redirect_to dashboard_path and return
    end
  end

  protected

  def resource_class
    User
  end

  def resource_name
    :user
  end
end
