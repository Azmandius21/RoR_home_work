module CompanyName
  attr_accessor :company_name
end

module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def register_instance
      @instance_counter ||= 0
      @instance_counter += 1
    end

    def instances
      @instance_counter
    end
  end

  module InstanceMethods
    protected

    def register_instance
      self.class.register_instance
    end
  end
end

module Validate
  def valid?
    validate!
    true
  rescue
    false
  end
end
