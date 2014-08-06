class DashboardsController < ApplicationController
  before_action :authenticate_user!, only: :show

  def show
    @user_presenter = UserPresenter.new(current_user)
  end
end
