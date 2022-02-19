=begin
  puts "Befor exception"
  Math.sqrt(-1)
rescue StandardError => e
  puts "Error!!!"
  raise
rescue NoMemoryError => e
  puts "No memorry!!!"
=end

#puts "After exception"
=begin
def method_with_error
  #...
  raise ArgumentError,"Oh no!"
end

begin
  method_with_error
rescue RuntimeError => e
  puts e.inspect
=end

#puts "After exception"
=begin
def sqrt(value)
  sqrt = Math.sqrt(value)
  puts sqrt
rescue StandardError
  puts "Invalid argument"
=end

def connect_to_wiki
  #...
  raise "connect error"
end

attempt =  0
begin
  connect_to_wiki
rescue NoMemoryError
  attempt += 1
  puts "Check your internet connections!"
  retry if attempt < 3
ensure
  puts "There was #{attempt} attempts"
end
