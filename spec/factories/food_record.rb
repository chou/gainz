FactoryGirl.define do
  factory :food_record do
    date DateTime.new(2011, 8, 1)
    name 'Bison Eye of Round'
    quantity 400
    units 'grams'
    user_id 441
    food_record_stat_id 492
  end
end
