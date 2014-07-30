require 'spec_helper'

describe UsersController, type: :controller do
  describe 'private methods' do
    before do
      UsersController.send(:public, *UsersController.private_instance_methods)
    end

    describe '#configure_permitted_parameters' do
      it 'adds User::PERMITTED_PARAMS to the whitelist' do
        user = double
        expect(user).to receive(:permit).with(:password,
                                              :password_confirmation,
                                              *User::PERMITTED_PARAMS)
        expect(controller.devise_parameter_sanitizer).
          to receive(:for).and_yield user

        controller.configure_permitted_parameters
      end
    end

    describe '#prep_params' do
      let(:user) { build(:user) }

      it 'should clean params' do
        expect(controller).to receive(:user_params).and_return user.attributes

        controller.prep_params
      end

      context 'when there is no password provided' do
        let(:submitted_params) do
          user.attributes.merge(password: '', password_confirmation: '')
        end

        it 'should remove password/confirmation if not provided' do
          expect(controller).to receive(:user_params).
            and_return submitted_params
          expect(submitted_params).to receive(:delete).with(:password).
            and_call_original
          expect(submitted_params).to receive(:delete).
            with(:password_confirmation).and_call_original

          controller.configure_permitted_parameters
          expect(controller.prep_params).
            to eq submitted_params.except(:password, :password_confirmation)
        end
      end
    end

    describe '#user_params' do
      it 'devise::sanitizes account_update attrs' do
        expect(controller.devise_parameter_sanitizer).
          to receive(:sanitize).with(:account_update)

        controller.user_params
      end
    end
  end

  describe '#new' do
    it 'renders new' do
      get :new

      expect(response).to render_template 'devise/registrations/new'
    end
  end

  describe '#create' do
    context 'when the params are complete' do
      let(:complete_params) do
        {
          user: {
            email: 'newgainz@here.com',
            password: 'thisissekretlulz',
            password_confirmation: 'thisissekretlulz'
          }
        }
      end

      it 'creates a new user' do
        users_count = User.all.count
        post :create, complete_params

        expect(User.all.count).to eq users_count + 1
      end

      it 'redirects to sign in after successful registration' do
        post :create, complete_params

        expect(response).to redirect_to new_user_session_path
      end
    end

    context 'when the params are incomplete' do
      let(:incomplete_params) { { email: 'newgainz@here.com' } }
      it 'renders the registration page' do
        post :create, incomplete_params

        expect(response).to render_template 'devise/registrations/new'
      end
    end
  end

  describe '#update' do
    let(:permitted_params) do
      { activity_x: 1.4,
        birthdate: '20110801',
        email: 'max@gainz.com',
        first_name: 'Max',
        height: 74,
        last_name: 'Gainz',
        lean_mass: 0.9,
        weight: 190
      }
    end
    let(:user) { create(:user, permitted_params) }

    context 'when there is a current user' do
      before do
        expect(controller).to receive(:current_user).
                  at_least(:once).and_return user
      end

      context 'and the account edited belongs to the current user' do
        before do
          expect(controller).to receive(:reject_unauthorized_actions)
        end

        context 'and the params are valid' do
          it 'should succeed and redirect to the dashboard path' do
            expect(controller).to receive(:prep_params).
              and_return user.attributes

            put :update, id: user.id, user: user.attributes

            expect(response).to redirect_to dashboard_path
            expect(User.find(user.id).height).to eq permitted_params[:height]
          end
        end

        context 'but the params are invalid' do
          let(:invalid_attrs) do
            user.attributes.merge 'activity_x' => 'FEELTHEPUMP'
          end

          it 'should call #add_generic_error!' do
            expect(controller).to receive(:prep_params).and_return invalid_attrs
            expect(controller).to receive :add_generic_error!

            put :update, id: user.id, user: invalid_attrs
            expect(response.status).to eq 400
            expect(response).to render_template 'dashboards/show'
          end
        end
      end

      context 'and the account edited does not belong to the current user' do
        let!(:victim) { build(:user, id: 1765) }
        let!(:malicious_user) { build(:user) }
        let(:troll_attrs) { victim.attributes.merge('first_name' => 'No') }

        before do
          expect(controller).to receive(:current_user_authorized?).
            and_return false
        end

        it 'should redirect to sign in' do
          put :update, id: victim.id, user: troll_attrs

          expect(response).to redirect_to new_user_session_path
        end
      end
    end

    let(:posted_params) { user.attributes.merge('first_name' => 'Moar') }

    it 'should load the current template vars' do
      expect(controller).to receive(:prep_params).and_return posted_params
      expect(controller).to receive(:current_user).at_least(:once).
        and_return user
      put :update, id: user.id, user: posted_params

      expect(assigns :id).to eq user.id
      expect(assigns :height).to eq user.height
      expect(assigns :weight).to eq user.weight
      expect(assigns :birthdate).to eq user.birthdate
      expect(assigns :lean_mass).to eq user.lean_mass
      expect(assigns :activity_x).to eq user.activity_x
      expect(assigns :first_name).to eq 'Moar'
      expect(assigns :last_name).to eq user.last_name
    end
  end
end
