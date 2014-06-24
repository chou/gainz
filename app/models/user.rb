class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_presence_of :email
  validates_presence_of :birthdate
  validates_presence_of :height
  validates_presence_of :weight
  validates_presence_of :activity_x
  validates_presence_of   :lean_mass
  validates_presence_of   :first_name
  validates_presence_of   :last_name

  validates_uniqueness_of :email

  PERMITTED_PARAMS = [ :email, :birthdate, :height, :weight, :activity_x,
                       :lean_mass, :first_name, :last_name ]

  def age
    ((DateTime.now - birthdate.to_datetime) / 365).round
  end

end
