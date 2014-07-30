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

      it 'passes along primary stats' do
        get :show
        expect(assigns :id).to eq user.id
        expect(assigns :height).to eq user.height
        expect(assigns :weight).to eq user.weight
        expect(assigns :birthdate).to eq user.birthdate
        expect(assigns :lean_mass).to eq user.lean_mass
        expect(assigns :first_name).to eq user.first_name
        expect(assigns :last_name).to eq user.last_name
        expect(assigns :activity_x).to eq user.activity_x
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
