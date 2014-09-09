require 'spec_helper'

describe FoodRecordsController do
  let(:user) { create(:user, id: 439) }

  before do
    allow(controller).to receive(:current_user).and_return user
  end

  describe '#create' do
    let(:food_record) { build(:food_record) }

    it 'makes a new food record object' do
      post :create, food_record: food_record.attributes, user_id: user.id, id: 324

      expect(assigns[:food_record]).to eq food_record
    end

    context 'when the inputs are valid' do
      it 'saves the new food record object' do
        expect do
          post :create, food_record: food_record.attributes, user_id: user.id
        end.to change { FoodRecord.all.count }.by 1
      end

      it 'renders the food records index' do
        post :create, food_record: food_record.attributes, user_id: user.id

        expect(response).to redirect_to '/eat'
      end
    end

    context 'when the inputs are invalid' do
      let(:invalid_food_record) do build(:food_record,
                                         units: 'unicorns',
                                         quantity: 'derrrrppp') end

      it 'does not save the food record' do
        expect do
          post :create, food_record: invalid_food_record.attributes, user_id: user.id
        end.not_to change { FoodRecord.all.count }
      end

      it 'populates flash errors' do
      end
    end
  end

  describe '#index' do
    it 'goes to the food records index for the current user' do
      get :index, user_id: user.id

      expect(assigns[:user_id]).to eq 439
    end
  end

  describe '#new' do
    context 'when current_user.id received does not match current user' do
      it 'renders for current user anyway' do
        get :new, user_id: 10

        expect(assigns[:user_id]).to eq 439
      end
    end

    it 'passes current_user.id' do
      get :new, user_id: user.id

      expect(assigns[:user_id]).to eq 439
    end
  end
end
