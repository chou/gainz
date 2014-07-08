require 'spec_helper'

describe ApplicationController do
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
        expect(controller).to receive(:current_user).and_return user
        expect(controller).to receive(:params).exactly(:twice).and_return new_attrs
      end

      it 'should return true' do
        expect(controller.current_user_authorized?).to be_truthy
      end
    end
  end

  describe '#authorize_user' do
    context "when current user is not authorized" do
      it 'redirects to sign in' do
        expect(controller).to receive(:current_user_authorized?).
          exactly(:once).and_return(false)
        expect_any_instance_of(ApplicationController).
          to receive(:redirect_to).with new_user_session_path

        controller.authorize_user
      end
    end

    context "when current user is authorized" do
      let(:user) { build(:user) }
      it 'does not redirect' do
        expect(controller).to receive(:current_user_authorized?).
          exactly(:once).and_return(true)

        controller.authorize_user
        expect_any_instance_of(ApplicationController).
          not_to receive(:redirect_to).with new_user_session_path
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
end
