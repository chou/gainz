require 'spec_helper'

describe FoodRecord do
  it { should validate_presence_of :name }
  it { should validate_presence_of :quantity }
  it { should validate_presence_of :units }
  it { should validate_presence_of :date }

  it { should validate_numericality_of :quantity }

  it { should ensure_inclusion_of(:units).in_array(described_class::UNITS) }

  it { should belong_to :user }
  it { should belong_to :food_record_stat }

  let(:user) { create(:user) }
  let(:food_record) { create(:food_record, user_id: user.id) }

  it 'should be a FoodRecord' do
    expect(food_record).to be_a FoodRecord
  end

  describe 'UNITS' do
    it 'should be an array' do
      expect(described_class::UNITS).to be_a Array
    end

    it 'should contain only strings' do
      described_class::UNITS.each do |unit|
        expect(unit).to be_a String
      end
    end
  end

  describe 'PERMITTED_PARAMS' do
    it 'should be an array' do
      expect(described_class::PERMITTED_PARAMS).to be_a Array
    end
  end

  describe '#==' do

    context 'when argument is not a FoodRecord' do
      let(:comparison) { 'not a FoodRecord' }
      let(:food_record) { build(:food_record, name: 'Peanut Butter Porter') }

      it 'returns false' do
        expect(food_record.==(comparison)).to be_falsy
      end
    end

    context 'when argument is of type FoodRecord' do
      let(:comparison) { build(described_class) }
      let(:food_record) { build(:food_record, name: 'Peanut Butter Porter') }

      it 'calls #attributes' do
        expect(food_record).to receive(:attributes).and_call_original

        food_record.== comparison
      end

      context 'when all the attributes are the same' do
        let(:first_food_record) do
          build(:food_record, name: 'Peanut Butter Porter')
        end

        let(:same_food_record) do
          build(:food_record, name: 'Peanut Butter Porter')
        end

        it 'returns true' do
          expect(first_food_record.==(same_food_record)).to be_truthy
        end
      end

      context 'when any attributes do not match' do
        let(:first_food_record) do
          build(:food_record, name: 'Peanut Butter Porter')
        end

        let(:different_food_record) do
          build(:food_record, name: 'Huckleberry Preserves')
        end

        it 'returns false' do
          expect(first_food_record.==(different_food_record)).to be_falsy
        end
      end
    end
  end
end
