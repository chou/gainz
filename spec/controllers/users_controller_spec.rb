require 'spec_helper'

describe UsersController, type: :controller do
  describe '#update' do
    let(:permitted_params){
                            { activity_x: '1.4',
                              birthdate: '20110801',
                              email: 'max@gainz.com',
                              first_name: 'Max',
                              height: '74',
                              last_name: 'Gainz',
                              lean_mass: '.9',
                              weight: '190'
                            }
                          }
    let(:user){ create(User, permitted_params) }

    context 'when the account edited belongs to the current user' do
      it 'should work' do
        # binding.pry
        put :update, id: user.id, user: user.attributes

        expect(response).to redirect_to dashboards_path
        expect(User.find(user.id).height).to eq 74
      end
    end
  end
end
