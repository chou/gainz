require 'spec_helper'

describe UsersController, type: :controller do
  describe '#update' do
    let(:permitted_params){
                            { activity_x: 1.4,
                              birthdate: '20110801',
                              email: 'max@gainz.com',
                              first_name: 'Max',
                              height: 74,
                              last_name: 'Gainz',
                              lean_mass: 0.9,
                              weight: 190
                            }
                          }
    let(:user){ create(User, permitted_params) }

    it 'should load the current template vars' do
      expect(controller).to receive(:current_user).at_least(:once).and_return user
      put :update, id: user.id, user: user.attributes.merge('first_name' => 'Moar')

      expect(assigns :id).to eq user.id
      expect(assigns :height).to eq user.height
      expect(assigns :weight).to eq user.weight
      expect(assigns :birthdate).to eq user.birthdate
      expect(assigns :lean_mass).to eq user.lean_mass
      expect(assigns :activity_x).to eq user.activity_x
      expect(assigns :first_name).to eq 'Moar'
      expect(assigns :last_name).to eq user.last_name
    end

    context 'when the account edited belongs to the current user' do
      before do
        expect(controller).to receive(:current_user).at_least(:once).and_return user
      end

      context 'when the params are valid' do
        it 'should succeed and redirect to the dashboard path' do
          put :update, id: user.id, user: user.attributes

          expect(response.status).to eq 302
          expect(User.find(user.id).height).to eq permitted_params[:height]
        end
      end

      context 'when the params are invalid' do

        let(:invalid_attrs){ user.attributes.merge 'activity_x' => 'FEELTHEPUMP' }

        it 'should call #add_generic_error!' do
          expect(controller).to receive :add_generic_error!
          put :update, id: user.id, user: invalid_attrs
          expect(response.status).to eq 400
          expect(response).to render_template 'dashboards/show'
        end
      end
    end

    context 'when the account edited does not belong to the current user' do
      let!(:victim) { create(User, id: 1765) }
      let!(:malicious_user) { create(User) }
      let(:troll_attrs) { victim.attributes.merge({ 'first_name' => 'No' }) }

      before do
        expect(User).to receive(:find).with(victim.id.to_s).and_return victim
        expect(controller).to receive(:current_user).at_least(:once).and_return malicious_user
      end


      it 'should forbid the update and re-render dashboards/show' do
        put :update, id: victim.id, user: troll_attrs

        expect(response.status).to eq 401
        expect(response).to render_template 'dashboards/show'
      end

      it 'should call #add_generic_error!' do
        expect(controller).to receive :add_generic_error!
        put :update, id: victim.id, user: troll_attrs
      end
    end
  end
end
