require 'spec_helper'

describe User do
  it { should validate_presence_of :email }
  it { should validate_uniqueness_of :email }

  it { should validate_presence_of(:birthdate).on(:update) }
  it { should validate_presence_of(:height).on(:update) }
  it { should validate_presence_of(:weight).on(:update) }
  it { should validate_presence_of(:lean_mass).on(:update) }
  it { should validate_presence_of(:activity_x).on(:update) }
  it { should validate_presence_of(:first_name).on(:update) }
  it { should validate_presence_of(:last_name).on(:update) }
end

describe User do
  context 'when updating the user' do
    user = FactoryGirl.create(:user)

    it 'should have a numerical height' do
      user.height = 'not_a_number'
      expect(user).not_to be_valid
    end

    it 'should have a numerical weight' do
      user.weight = 'not_a_number'
      expect(user).not_to be_valid
    end

    it 'should have a numerical lean_mass' do
      user.lean_mass = 'not_a_number'
      expect(user).not_to be_valid
    end

    it 'should have a numerical activity_x' do
      user.activity_x = 'not_a_number'
      expect(user).not_to be_valid
    end
  end

  describe '#age' do
    let! (:user) { build(:user, birthdate: Date.new(2000, 1, 1)) }

    it "should return the user's age in years" do
      Timecop.freeze(Date.new(2014, 1, 1)) do
        expect(user.age).to eq 14
      end
    end
  end
end
