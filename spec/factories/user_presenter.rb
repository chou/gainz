FactoryGirl.define do
  factory :user_presenter do
    email 'random'
    birthdate DateTime.new(2011, 8, 1)
    lean_mass 95.2
    activity_x 2
    height 74
    weight 120
    first_name 'Max'
    last_name 'Gainz'
  end
end
