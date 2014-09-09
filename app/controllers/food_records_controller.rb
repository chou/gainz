class FoodRecordsController < ApplicationController
  def create
    @food_record = FoodRecord.new(params[:food_record].permit(FoodRecord::PERMITTED_PARAMS))

    if @food_record.save
      redirect_to eat_index_path and return
    else
      flash[:error] = @food_record.errors.full_messages
      redirect_to new_user_food_record_path user_id: current_user.id
    end
  end

  def index
    @user_id = current_user.id
  end

  def new
    @user_id = current_user.id
  end
end
