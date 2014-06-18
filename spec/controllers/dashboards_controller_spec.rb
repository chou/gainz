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
