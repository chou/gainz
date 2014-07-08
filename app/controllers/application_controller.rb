class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  GENERIC_ERROR_MSG = 'Something went wrong; please try again.'.freeze

  def add_generic_error!
    flash[:error] = GENERIC_ERROR_MSG
  end

  def after_sign_in_path_for(resource)
    dashboard_path
  end

  def authorize_user
    redirect_to new_user_session_path unless current_user_authorized?
  end

  def current_user_authorized?
    if params[:user]
      params[:user]['id'].to_i == current_user.id
    else
      flash[:error] = 'Missing user params'
      false
    end
  end
end
