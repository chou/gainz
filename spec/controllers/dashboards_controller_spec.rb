require 'spec_helper'

describe DashboardsController, type: :controller do
  describe '#index' do
    context 'when there is a user logged in' do
      let!(:user){ create(:user) }

      before do
        sign_in user
      end

      it 'successfully renders the index' do
        get :index
        expect(response).to be_success
        expect(response).to render_template "dashboards/index"
      end

      it 'passes along primary stats' do
        get :index
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
        get :index
        expect(response).not_to be_success
      end
    end
  end
end
