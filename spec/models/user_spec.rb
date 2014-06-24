require 'spec_helper'

describe User do
   it { should validate_presence_of :email }
   it { should validate_presence_of :birthdate }
   it { should validate_presence_of :height }
   it { should validate_presence_of :weight }
   it { should validate_presence_of :lean_mass }
   it { should validate_presence_of :activity_x }
   it { should validate_presence_of :first_name }
   it { should validate_presence_of :last_name }

  it { should validate_uniqueness_of :email }

end
