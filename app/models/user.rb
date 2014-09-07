class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :email, presence: true, uniqueness: true
  validates :birthdate, presence: true,  on: :update
  validates :height, presence: true, numericality: true, on: :update
  validates :weight, presence: true, numericality: true, on: :update
  validates :activity_x, presence: true, numericality: true, on: :update
  validates :lean_mass, presence: true, numericality: true, on: :update
  validates :first_name, presence: true, on: :update
  validates :last_name, presence: true,  on: :update

  validate :birthdate_is_date, on: :update

  PERMITTED_PARAMS = [:email, :birthdate, :height, :weight, :activity_x,
                      :lean_mass, :first_name, :last_name, :goal].freeze

  PRIMARY_STATS = [:email, :birthdate, :height, :weight, :activity_x,
                   :lean_mass, :first_name, :last_name, :id, :goal]

  def age
    ((Date.today - birthdate) / 365).round unless birthdate.nil?
  end

  private

  def birthdate_is_date
    errors.add(:birthdate, 'must be a valid date') unless birthdate.is_a? Date
  end
end
