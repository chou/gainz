class UserPresenter
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :email, :birthdate, :height, :weight, :activity_x,
                :lean_mass, :first_name, :last_name

  def initialize(user)
    @email      = user.email
    @birthdate  = user.birthdate
    @height     = user.height
    @weight     = user.weight
    @activity_x = user.activity_x
    @lean_mass  = user.lean_mass
    @first_name = user.first_name
    @last_name  = user.last_name
  end

  def attributes
    Hash[ instance_variables.map do |var|
      symbolized_var = var[1..-1].to_sym
      [symbolized_var, instance_variable_get(var)]
    end
    ]
  end
end
