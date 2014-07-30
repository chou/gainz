require 'spec_helper'

describe HomesController, type: :controller do
  describe '#show' do
    it 'successfully renders the show' do
      get :show
      expect(response).to be_success
      expect(response).to render_template 'homes/show'
    end
  end
end
