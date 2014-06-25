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

end
