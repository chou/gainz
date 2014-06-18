class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_presence_of :email
  validates_presence_of :birthdate
  validates_presence_of :height
  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_uniqueness_of :email

end
