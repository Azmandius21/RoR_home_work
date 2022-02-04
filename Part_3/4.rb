#Create empty Array and Hash
a = Array.new
hash = Hash.new

#fill array with alphabet letters 'a'- 'z'
for i in ("a".."z")
  a << i
end

#fill Hash with letters 'a','e','i','o','u','y'
a.each do |letter|
  if letter =~ /[aeiouy]/
    hash[letter] = a.index(letter)+1
  end
end

#display hash
puts hash
