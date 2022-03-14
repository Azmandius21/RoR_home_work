class Foo
  def bar(key)
    h = { a: 1, b: 2 }
    value = h[key]
    value ||= 0
  end

  def long_method
    sleep(3)
  end

  def memoization
    @m ||= long_method
  end
end

class User
  attr_accessor :name

  def has_name?
    !!name
  end

  def has_not_name?
    !has_name?
  end
end

class Color
  COLORS = { red: '#foo', green: '#ffo' }

  def code(name)
    @code = COLORS[name] || '#fff'
  end

  alias_method :by_name, :code
end

class Train
  attr_accessor :number, :type, :model, :wagon

  def initialize(number, options = {})
    @number = number
    @type = options[:type] || "Unknown"
    @model = options[:model] || "Unknown"
    @wagon = options[:wagon] || 0
  end
end
