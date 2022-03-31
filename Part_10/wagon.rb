# frozen_string_literal: true
require_relative 'validate_module'
require_relative 'accessor_module'

class Wagon
  include CompanyName
  include Validations
  extend Accessor

  attr_reader :total_place, :used_place, :type_wagon

  validate :total_place, :presence
  validate :total_place, :format_validation, /^\d{1,6}$/
  validate :total_place, :kind_class, Integer

  def initialize(total_place)
    @total_place = total_place
    @used_place = 0
    validate!
  end

  def free_place
    total_place - used_place
  end

  protected

  attr_writer :used_place
end
