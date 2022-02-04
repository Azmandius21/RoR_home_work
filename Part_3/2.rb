#create empty array "a".
a= []
#fill array with multiples of "5"
for i in (1..100)
  if i%5 == 0
    a << i
  end
end
#display result
puts a 
