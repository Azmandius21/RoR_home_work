module CompanyName
  attr_accessor :company_name

  def production(company)
    self.company_name = company
  end

  def brand
    self.company_name
  end  
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