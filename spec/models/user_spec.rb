require 'spec_helper'

describe User do
   it { should validate_presence_of :email }
   it { should validate_presence_of(:birthdate).on(:update) }
   it { should validate_presence_of(:height).on(:update) }
   it { should validate_presence_of(:weight).on(:update) }
   it { should validate_presence_of(:lean_mass).on(:update) }
   it { should validate_presence_of(:activity_x).on(:update) }
   it { should validate_presence_of(:first_name).on(:update) }
   it { should validate_presence_of(:last_name).on(:update) }

   it { should validate_uniqueness_of :email }
   it { should validate_numericality_of(:height) }
   it { should validate_numericality_of(:weight) }
   it { should validate_numericality_of(:lean_mass) }
   it { should validate_numericality_of(:activity_x) }

  describe '#age' do
    let! (:user) { create(User, birthdate: Date.new(2000, 1, 1)) }

    it "should return the user's age in years" do
      Timecop.freeze(Date.new(2014,1,1)) do
        expect(user.age).to eq 14
      end
    end
  end
end
