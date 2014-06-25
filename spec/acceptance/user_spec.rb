require 'spec_helper'
require 'helpers/acceptance_spec_helpers'

describe 'a user', type: :feature do
  describe 'a person signing up' do
    it 'is successful' do
      visit root_url
      click_on 'Sign Up'

      fill_in 'user[email]', with: 'max@gainz.com'
      fill_in 'user[password]', with: 'fakepassword'
      fill_in 'user[password_confirmation]', with: 'fakepassword'
      
      expect { click_on 'Sign up' }.to change { User.all.count }.by 1
      expect(User.last.email).to eq 'max@gainz.com'
    end
  end

  let!(:user) {
    FactoryGirl.create(User, first_name: 'Max', last_name: 'Gainz',
                 password: '1moarREP', height: 180
    )}

  describe 'a user logging in' do
    it 'has a happy path' do
      visit root_url
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: '1moarREP'
      click_on 'Log In'

      expect(current_path).to eq dashboards_path
      expect(page).to have_content 'Max'
    end
  end

  describe 'an onboarding user' do
    before do
      sign_in_user user
    end

    def extract_primary_stats
      primary_stats_keys = ['height', 'lean_mass', 'activity_x', 'weight']
      primary_stats = user.attributes.select { |a| primary_stats_keys.include? a }
    end

    it 'can enter primary stats' do
      primary_stats = extract_primary_stats

      primary_stats.each do |key, val|
        fill_in "user[#{key}]", with: val
      end

      click_on 'Save'
      visit dashboards_path

      primary_stats.each do |key, val|
        expect(find_field("user[#{key}]").value).to eq val.to_s
      end
    end
  end
end
