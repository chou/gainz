require 'spec_helper'
require 'helpers/acceptance_spec_helpers'

describe 'a user' do
  let!(:user) {
    create(User, first_name: 'Max', last_name: 'Gainz', email: 'max@gainz.com',
                 password: '1moarREP', height: 180)
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
    before do
      sign_in_user user
    end

    def extract_primary_stats
      primary_stats_keys = ['height', 'birthdate', 'lean_mass', 'activity_x', 'weight']
      primary_stats = user.attributes.select { |a| primary_stats_keys.include? a }
    end

    it 'can enter primary stats' do
      primary_stats = extract_primary_stats

      click_on 'Profile'

      primary_stats.each do |key, val|
        fill_in "user[#{key}]", with: val
      end

      click_on 'Save'
      visit current_path

      primary_stats.each do |_, val|
        expect(page).to have_content val
      end
    end
  end
end
