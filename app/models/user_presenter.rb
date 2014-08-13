class UserPresenter
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :email, :birthdate, :height, :weight, :activity_x,
                :lean_mass, :first_name, :last_name, :id, :goal

  def initialize(user)
    @id         = user.id
    @email      = user.email
    @birthdate  = user.birthdate
    @height     = user.height
    @weight     = user.weight
    @activity_x = user.activity_x
    @lean_mass  = user.lean_mass
    @first_name = user.first_name
    @last_name  = user.last_name
    @goal       = user.goal
  end

  def attributes
    symbolized_ivars = instance_variables.map do |var|
      var[1..-1].to_sym
    end
    ivals = symbolized_ivars.map do |symbolized_var|
      [symbolized_var, instance_variable_get("@#{symbolized_var}")]
    end
    Hash[ivals]
  end
end
