require 'spec_helper'

describe AccountsController do
  describe '#show' do
    let!(:user){ build(:user) }

    it 'authenticates the user' do
      expect(controller).to receive(:current_user_authorized?)
      expect(controller).to receive(:current_user).at_least(:once).and_return user

      get :show, user: user.attributes
    end

    it 'passes all account vars' do
      expect(controller).to receive(:current_user).at_least(:once).and_return user
      get :show, user: user.attributes

      account_vars = [:first_name, :last_name, :birthdate, :email]
      account_vars.each do |account_var|
        expect(assigns(account_var)).to eq user.send account_var
      end
    end
  end
end
