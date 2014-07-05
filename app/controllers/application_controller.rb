class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  GENERIC_ERROR_MSG = 'Something went wrong; please try again.'.freeze

  def add_generic_error!
    flash[:error] = GENERIC_ERROR_MSG
  end

  def after_sign_in_path_for(resource)
    dashboards_path
  end

  def current_user_authorized?
    params[:user]['id'].to_i == current_user.id
  end
end
