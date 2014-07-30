FactoryGirl.define do
  sequence :email do |n|
    "max@gainz_#{n}.com"
  end

  factory :user do
    email
    password '7n4qGRW47gc^$#b'
    birthdate DateTime.new(2011, 8, 1)
    lean_mass 95.2
    activity_x 2
    height 74
    weight 120
    first_name 'Max'
    last_name 'Gainz'
  end
end
