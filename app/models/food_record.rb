class FoodRecord < ActiveRecord::Base
  belongs_to :food_record_stats
  belongs_to :user

  validates :date, presence: true
  validates :name, presence: true
  validates :quantity, presence: true, numericality: true
  validates :units, presence: true

  UNITS = %w(grams ounces).freeze
end
