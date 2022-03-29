module Accessor
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def attr_accessor_with_history(*names)
      names.each do |name|
        var_name = "@#{name}".to_sym
        var_history_name = "@history_#{name}".to_sym

        define_method(name) { instance_variable_get(var_name) }

        define_method("#{name}_history".to_sym) { instance_variable_get(var_history_name) }

        define_method("#{name}=") do |value|
          instance_variable_set(var_name, value)
          var = instance_variable_get(var_history_name) ||
                instance_variable_set(var_history_name, [])
          var << value
        end
      end
    end

    def strong_attr_accessor(name, klass)
      var_name = "@#{name}".to_sym

      define_method(name) { instance_variable_get(var_name) }

      define_method("#{name}=") do |value|
        raise "the class of value '#{value.class}' isn't valid." unless value.is_a?(klass)

        instance_variable_set(var_name, value)
      rescue RuntimeError => e
        puts e.message
      end
    end
  end
end

# class X
#   include Accessor
#
#   attr_accessor_with_history :bar, :foo
#   strong_attr_accessor :qwe, String
#
#   eval <<-RUBY
#     x = X.new
#     x.bar = 1
#     x.bar = 2
#     x.bar = 4
#   #  x.history_bar.inspect
#   RUBY
# end
