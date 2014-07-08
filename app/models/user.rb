class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_presence_of :email
  validates_presence_of :birthdate,  on: :update
  validates_presence_of :height,     on: :update
  validates_presence_of :weight,     on: :update
  validates_presence_of :activity_x, on: :update
  validates_presence_of :lean_mass,  on: :update
  validates_presence_of :first_name, on: :update
  validates_presence_of :last_name,  on: :update

  validates :height,      numericality: true, on: :update
  validates :weight,      numericality: true, on: :update
  validates :activity_x,  numericality: true, on: :update
  validates :lean_mass,   numericality: true, on: :update

  validate :birthdate_is_date, on: :update
  validates_uniqueness_of :email

  PERMITTED_PARAMS = [ :email, :birthdate, :height, :weight, :activity_x,
                       :lean_mass, :first_name, :last_name ].freeze

  def age
    if birthdate
      return ((Date.today - birthdate) / 365).round
    end
  end

  private

  def birthdate_is_date
    unless birthdate.is_a? Date
      errors.add(:birthdate, "must be a valid date")
    end
  end
end
