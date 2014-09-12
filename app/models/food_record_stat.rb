class FoodRecordStat < ActiveRecord::Base
  PERMITTED_PARAMS = [:amount, :calories, :carb, :cholesterol,
                      :fiber, :name, :protein, :sat_fat, :sodium,
                      :sugar, :tot_fat, :units, :trans_fat]
  UNITS = %w(grams ounces).freeze

  validates :amount, :calories, :carb, :cholesterol, :fiber, :protein, :sat_fat, :sodium, :sugar, :tot_fat, :trans_fat, presence: true, numericality: true
  validates :name, presence: true
  validates :units, presence: true, inclusion: { in: FoodRecordStat::UNITS }

  def ==(other)
    return false unless other.is_a? FoodRecordStat
    attributes.except('id').each do |key, val|
      return false unless val == other.attributes.except('id')[key]
    end
    true
  end
end
