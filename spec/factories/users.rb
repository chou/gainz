# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    email 'max@gainz.com'
    password "7n4qGRW47gc^$#b"
    birthdate DateTime.new(2011, 8, 1)
    height 74
    first_name 'Max'
    last_name 'Gainz'
  end
end
