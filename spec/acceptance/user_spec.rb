require 'spec_helper'

describe 'a user' do
  let!(:user) {
    create(User, first_name: 'Max', last_name: 'Gainz', email: 'max@gainz.com',
                 password: '1moarREP')
  }

  describe 'a user logging in', type: :feature do
    it 'has a happy path' do
      visit root_url
      fill_in 'user[email]', with: 'max@gainz.com'
      fill_in 'user[password]', with: '1moarREP'
      click_on 'Log In'

      expect(current_path).to eq dashboards_path
      expect(page).to have_content 'Max'
    end
  end

  describe 'an onboarding user', type: :feature do
    it 'can enter primary stats' do
      
    end
  end
end
