require 'spec_helper'
require 'helpers/acceptance_spec_helpers'

describe 'a user', type: :feature do
  describe 'signing up' do
    it 'is successful' do
      visit root_url
      click_on 'Make Gainz'

      fill_in 'user[email]', with: 'new_user@gainz.com'
      fill_in 'user[password]', with: 'fakepassword'
      fill_in 'user[password_confirmation]', with: 'fakepassword'

      expect do
        within('.new_user') do
          click_on 'Sign Up'
        end
      end.to change { User.all.count }.by 1

      expect(User.last.email).to eq 'new_user@gainz.com'
    end
  end

  let!(:user) do
    FactoryGirl.create(:user, first_name: 'Max', last_name: 'Gainz',
                              password: '1moarREP', height: 180, id: 4123)
  end

  describe 'logging in' do
    it 'has a happy path' do
      visit root_url
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: '1moarREP'
      click_on 'Log In'

      expect(current_path).to eq dashboard_path
      expect(page).to have_content 'Max'
    end
  end

  describe 'onboarding' do
    before do
      sign_in_user user
    end

    def extract_primary_stats
      primary_stats_keys = %w(height lean_mass activity_x weight)
      user.attributes.select { |a| primary_stats_keys.include? a }
    end

    it 'can sign out' do
      visit dashboard_path
      click_on 'Sign Out'
      expect(page).to have_content 'Make Gainz'
    end

    it 'can enter primary stats' do
      visit dashboard_path

      primary_stats = extract_primary_stats
      primary_stats.each do |key, val|
        fill_in "user[#{key}]", with: val
      end

      click_on 'Save'
      visit dashboard_path

      primary_stats.each do |key, val|
        expect(find_field("user[#{key}]").value).to eq val.to_s
      end
    end

    it 'can edit account information' do
      visit account_path

      fill_in 'user[first_name]', with: 'Doyou'
      fill_in 'user[last_name]', with: 'Evenlift'

      click_on 'Save'

      expect(User.find(4123).first_name).to eq 'Doyou'
      expect(User.find(4123).last_name).to eq 'Evenlift'
    end
  end

  describe 'choosing a goal' do
    before do
      sign_in_user user
    end

    def assert_goal(goal)
      within '.goal' do
        click_on goal
      end
      visit dashboard_path
      expect(page).to have_content goal
    end

    xit 'can select and persist a goal' do
      visit dashboard_path

      expect(page).to have_content 'Choose a goal to get started!'

      assert_goal('Cut')
      assert_goal('Bulk')
      assert_goal('Recomp')
    end
  end

  describe 'logging' do
    before do
      sign_in_user user
    end

    describe 'consumption' do
      it 'can log food entries' do
        click_on 'Eat'
        click_on 'Add'
        fill_in 'food_record_name', with: 'Halal Cart Chicken & Rice'
        fill_in 'food_record_quantity', with: '500'
        fill_in 'food_record_units', with: 'grams'
        fill_in 'food_record_date', with: '2007/07/07'
        click_on 'Done'

        visit eat_index_path

        expect(page).to have_content 'Halal Cart Chicken & Rice'
      end
    end

    describe 'expenditure' do
      xit 'can log training entries' do
        click_on 'Train'
        click_on 'Add'
        fill_in 'exercise', with: 'Squats'
        fill_in 'weight', with: '165'
        fill_in 'reps', with: '5'
        click_on 'Done'

        visit new_user_train_path(current_user)

        expect(page).to have_content 'Squats'
        expect(page).to have_content '165'
      end
    end
  end
end
