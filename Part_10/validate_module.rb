module Validations
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
    base.class_variable_set :@@validation, {}
  end

  module ClassMethods
    def validation
      class_variable_get :@@validation
    end

    def validate(attr, type_validation, parametrs = '')
      @count ||= 1
      count = "Valid#{@count}".to_sym
      validation[count] = [attr, type_validation, parametrs]
      @count += 1
    end
  end

  module InstanceMethods
    def validate!
      instance_variable_set :@errors, []
      self.class.validation.each do |_num, arg|
        type_validation = arg[1]
        attr = instance_variable_get "@#{arg.first}".to_sym
        send type_validation, attr, arg.last, arg.first
      end
      raise @errors.join(' | ') unless @errors.empty?
    end

    def valid?
      validate!
      puts true
    rescue
      puts false
    end

    private

    def presence(value, _arg, attr)
      @errors << "Attribute '#{attr}' is nil" if value.nil? || value == ''
    end

    def format_validation(value, format_validation, attr)
      @errors << "Type of '#{attr}' is not from Regexp #{format_validation}" unless value.to_s =~ format_validation
    end

    def kind_class(value, klass, attr)
      @errors << "Class of '#{attr}' #{value.class} invalid != #{klass}" unless value.instance_of?(klass)
    end

    def size_validation(value, size_valid_var, attr)
      @errors << "Invalid size of instance variable '#{attr}'" unless value.size >= size_valid_var
    end
  end
end
