class AccountsController < ApplicationController
  before_filter :current_user_authorized?

  def show
    @first_name = current_user.first_name
    @last_name  = current_user.last_name
    @email      = current_user.email
    @birthdate  = current_user.birthdate
  end
end
