class DashboardsController < ApplicationController
  before_action :authenticate_user!, only: :index

  def index
    @first_name = current_user.first_name
  end

end
