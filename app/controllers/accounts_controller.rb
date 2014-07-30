class AccountsController < ApplicationController
  before_action :require_session

  def show
    @birthdate  = current_user.birthdate
    @email      = current_user.email
    @first_name = current_user.first_name
    @id         = current_user.id
    @last_name  = current_user.last_name
  end
end
