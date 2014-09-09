require 'spec_helper'

describe FoodRecordsController do
  let(:user) { create(:user, id: 439) }

  before do
    allow(controller).to receive(:current_user).and_return user
  end

  describe '#create' do
    let(:food_record) { build(:food_record, user_id: user.id) }

    it 'makes a new food record object' do
      post :create,
           food_record: food_record.attributes,
           user_id: user.id,
           id: 324

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
      let(:invalid_food_record) do
        build(:food_record, units: 'unicorns', quantity: 'derrrrppp')
      end

      it 'does not save the food record' do
        expect do
          post :create,
               food_record: invalid_food_record.attributes,
               user_id: user.id
        end.not_to change { FoodRecord.all.count }
      end

      xit 'populates flash errors' do
      end
    end

    context 'when the user_id in params are different from current_user.id' do
      let(:invalid_units_food_record) do
        build(:food_record, units: 'unicorns')
      end

      let(:invalid_qty_food_record) do
        build(:food_record, quantity: 'derrrrppp')
      end

      let(:invalid_user_id_food_record) do
        build(:food_record)
      end

      it 'does not save the food record' do
        expect do
          post :create,  food_record: invalid_units_food_record.attributes,
                         user_id: 1

        end.not_to change { FoodRecord.all.count }

        expect do
          post :create,  food_record: invalid_qty_food_record.attributes,
                         user_id: 1

        end.not_to change { FoodRecord.all.count }

        expect do
          post :create,  food_record: invalid_user_id_food_record.attributes,
                         user_id: 1

        end.not_to change { FoodRecord.all.count }
      end

      xit 'populates flash errors' do
      end
    end
  end

  describe '#index' do
    it 'goes to the food records index for the current user' do
      get :index, user_id: user.id

      expect(assigns[:user_id]).to eq 439
    end

    it 'passes along all food records for current user' do
      user = create(:user, id: 684)
      food_record = user.food_records.create(name: 'Oats',
                                             quantity: 4,
                                             units: 'ounces',
                                             date: '2014/08/10')

      allow(controller).to receive(:current_user).and_return user

      get :index, user_id: user.id

      expect(assigns[:food_records].length).to eq 1
      expect(assigns[:food_records].first).to eq food_record
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
