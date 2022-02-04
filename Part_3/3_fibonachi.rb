fibonachi = [0,1]
x = 0
i = 1
begin
  x = fibonachi[i-1]+fibonachi[i]
  i += 1
  if x < 100
    fibonachi << x
  end
end while x < 100
puts fibonachi
