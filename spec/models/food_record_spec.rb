require 'spec_helper'

describe FoodRecord do
  it { should validate_presence_of :name }
  it { should validate_presence_of :quantity }
  it { should validate_presence_of :units }
  it { should validate_presence_of :date }

  it { should validate_numericality_of :quantity }

  it { should belong_to :user }
  xit { should belong_to :food_record_stats }

  let(:user) { create(:user) }
  let(:food_record) { create(:food_record, user_id: user.id) }

  it 'should be a FoodRecord' do
    expect(food_record).to be_a(FoodRecord)
  end

  it 'should have a String for name' do
    expect(food_record.name).to be_a String
  end

  it 'should accept only grams or ounces as units' do
    expect(FoodRecord::UNITS).to include food_record.units
  end
end
