class FoodRecord < ActiveRecord::Base
  belongs_to :food_record_stats
  belongs_to :user

  PERMITTED_PARAMS = [:date, :food_record_stats_id, :name,
                      :quantity, :units, :user_id]
  UNITS = %w(grams ounces).freeze

  validates :date, presence: true
  validates :name, presence: true
  validates :quantity, presence: true, numericality: true
  validates :units, presence: true, inclusion: { in: UNITS }

  def ==(other)
    return false unless other.is_a? FoodRecord
    attributes.except('id').each do |key, val|
      return false unless val == other.attributes.except('id')[key]
    end
    true
  end
end
