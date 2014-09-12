require 'spec_helper'

describe FoodRecordStat do
  it { should validate_presence_of :amount }
  it { should validate_presence_of :calories }
  it { should validate_presence_of :carb }
  it { should validate_presence_of :cholesterol }
  it { should validate_presence_of :fiber }
  it { should validate_presence_of :name }
  it { should validate_presence_of :protein }
  it { should validate_presence_of :sat_fat }
  it { should validate_presence_of :sodium }
  it { should validate_presence_of :sugar }
  it { should validate_presence_of :tot_fat }
  it { should validate_presence_of :units }
  it { should validate_presence_of :trans_fat }

  it { should validate_numericality_of :amount }
  it { should validate_numericality_of :calories }
  it { should validate_numericality_of :carb }
  it { should validate_numericality_of :cholesterol }
  it { should validate_numericality_of :fiber }
  it { should validate_numericality_of :protein }
  it { should validate_numericality_of :sat_fat }
  it { should validate_numericality_of :sodium }
  it { should validate_numericality_of :sugar }
  it { should validate_numericality_of :tot_fat }
  it { should validate_numericality_of :trans_fat }

  it { should ensure_inclusion_of(:units).in_array(FoodRecordStat::UNITS) }

  let(:food_record_stat) { create(:food_record_stat) }

  it 'should be a FoodRecordStat' do
    expect(food_record_stat).to be_valid
  end

  describe 'UNITS' do
    it 'should be an array' do
      expect(described_class::UNITS).to be_a Array
    end

    it 'should be right' do
      expect(described_class::UNITS).to eq ['grams', 'ounces']
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
    context 'when argument is not a FoodRecordStat' do
      let(:comparison) { 'not a FoodRecordStat' }
      let(:food_record_stat) { build(described_class, name: 'Peanut Butter Porter') }

      it 'returns false' do
        expect(food_record_stat.==(comparison)).to be_falsy
      end
    end

    context 'when argument is of type FoodRecordStat' do
      let(:comparison) { build(described_class) }
      let(:food_record_stat) { build(described_class, name: 'Peanut Butter Porter') }

      it 'calls #attributes' do
        expect(food_record_stat).to receive(:attributes).and_call_original

        food_record_stat.== comparison
      end

      context 'when all the attributes are the same' do
        let(:first_food_record_stat) do
          build(described_class, name: 'Peanut Butter Porter')
        end

        let(:same_food_record_stat) do
          build(described_class, name: 'Peanut Butter Porter')
        end

        it 'returns true' do
          expect(first_food_record_stat.==(same_food_record_stat)).to be_truthy
        end
      end

      context 'when any attributes do not match' do
        let(:first_food_record_stat) do
          build(described_class, name: 'Peanut Butter Porter')
        end

        let(:different_food_record_stat) do
          build(described_class, name: 'Huckleberry Preserves')
        end

        it 'returns false' do
          expect(first_food_record_stat.==(different_food_record_stat)).to be_falsy
        end
      end
    end
  end
end
