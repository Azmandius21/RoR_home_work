#create empty hash
purchases = Hash.new
#create variable for tottal price of all purchases
total_price = 0

#cicle for add all data about purchases
while nil == nil do

  puts "What are you bought?"
  product = gets.chomp

  # break condition
  if product == "stop" || product == "стоп"
    break
  end
  purchases[product]= Hash.new

  puts "How much it cost ?"
  cost = gets.chomp.to_f
  purchases[product]["it cost"] = cost

  puts "How many did you buy?"
  quantity = gets.chomp.to_f
  purchases[product]["bought quantity"] = quantity


  total_price_for_one_product = cost * quantity
  purchases[product]["total price"] = total_price_for_one_product

  #calculation total price
  total_price += total_price_for_one_product
end

#display result for one product
purchases.each do |key,value|
  puts "#{key} : #{value}"
end

#diisplay total price
puts "Total price for all products #{total_price} RUB."
