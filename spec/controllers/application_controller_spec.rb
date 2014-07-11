require 'spec_helper'

describe ApplicationController do

  it 'has proper Devise integration' do
    ApplicationController.send(:public, :resource_class, :resource_name)

    expect(controller.resource_class).to eq User
    expect(controller.resource_name).to eq :user
  end

  describe '#require_session' do
    let(:user) { build(:user, id: 853) }

    context 'when there is no current user' do
      it 'redirects to sign in' do
        expect(controller).to receive(:current_user).and_return nil
        expect(controller).to receive(:redirect_to).with new_user_session_path

        controller.require_session
      end
    end

    context 'when there is a current user' do
      let(:user) { build(:user, id: 853) }

      it 'does not redirect' do
        expect(controller).to receive(:current_user).and_return user

        controller.require_session
        expect(controller).not_to receive(:redirect_to).
          with new_user_session_path
      end
    end
  end

  describe '#add_generic_error!' do
    it 'should add a particular string to flash[:error]' do
      expect { controller.add_generic_error! }.
        to change { flash[:error] }.
          to ApplicationController::GENERIC_ERROR_MSG
    end
  end

  describe '#current_user_authorized?' do
    context "when current user has different id from params[:user]['id']" do
      let!(:victim) { build(:user, id: 1765) }
      let(:malicious_user) { build(:user) }
      let(:troll_attrs) { { user: victim.attributes.merge({ 'first_name' => 'No' }) } }

      before do
        expect(controller).to receive(:current_user).and_return malicious_user
        expect(controller).to receive(:params).exactly(:twice).and_return troll_attrs
      end

      it 'should return false' do
        expect(controller.current_user_authorized?).to be_falsy
      end
    end

    context "when current user has same id as params[:user]['id']" do
      let(:user) { build(:user, id: 4888) }
      let(:new_attrs) { { user: user.attributes.merge({ 'activity_x' => 2 }) } }

      before do
        expect(controller).to receive(:current_user).
          at_least(:once).and_return user
        expect(controller).to receive(:params).exactly(:twice).and_return new_attrs
      end

      it 'should return true' do
        expect(controller.current_user_authorized?).to be_truthy
      end
    end
  end

  describe '#reject_unauthorized_actions' do
    context "when current user is not authorized" do
       it 'redirects to sign in' do
        expect(controller).to receive(:require_session)
        expect(controller).to receive(:current_user_authorized?).
          exactly(:once).and_return(false)
        expect(controller).to receive(:redirect_to).with new_user_session_path

        controller.reject_unauthorized_actions
       end
     end

    context "when current user is authorized" do
      let(:user) { build(:user) }
       it 'does not redirect' do
        expect(controller).to receive(:require_session)
        expect(controller).to receive(:current_user_authorized?).
          exactly(:once).and_return(true)

        controller.reject_unauthorized_actions
        expect(controller).not_to receive(:redirect_to)
       end
    end
  end
end
