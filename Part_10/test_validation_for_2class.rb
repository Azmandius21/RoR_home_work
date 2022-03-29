require_relative 'validate_module.rb'

class X
include Validations

validate :name, :presence
validate :name, :format_validation, /^\w+$/
validate :name, :kind_class, String
validate :age, :presence
validate :age, :format_validation, /^\d+$/
validate :age, :kind_class, String

  def initialize
    @name,@age = "Aziz","33"
  end
end

class Y
  include Validations

  validate :boo, :presence
  validate :boo, :format_validation, /^\d+$/
  validate :boo, :kind_class, Integer
  validate :foo, :presence
  validate :foo, :format_validation, /^\d+$/
  validate :foo, :kind_class, Integer

  def initialize
    @boo,@foo = 32, 41
  end
end
