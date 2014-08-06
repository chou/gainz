require 'spec_helper'

describe DashboardsController, type: :controller do
  describe '#show' do
    let!(:user) { create(:user) }

    it 'checks for authentication' do
      expect(controller).to receive(:authenticate_user!)
      expect(controller).to receive(:current_user).
        at_least(:once).and_return user

      get :show
    end

    context 'when there is a user logged in' do
      before do
        sign_in user
      end

      it 'successfully renders show' do
        get :show
        expect(response).to be_success
        expect(response).to render_template 'dashboards/show'
      end

      xit 'passes along primary stats' do
        get :show
        expect(assigns(:user_presenter).attributes).
          to eq user.attributes.select { |k, _| User::PRIMARY_STATS.include? k }
      end
    end

    context 'when there is no user logged in' do
      before do
        sign_out :all
      end

      it 'redirects to the login page' do
        get :show
        expect(response).not_to be_success
      end
    end
  end
end
