#create base of number of day in each month of the year
year_default = {1 => 31, 2 => 28, 3 => 31, 4 => 30, 5 => 31, 6 => 30,
        7 => 31, 8 => 31, 9 => 30, 10 => 31, 11 => 30, 12 => 31 }

#Detect is this year intecalary
def leap_year?(year)
  if year % 4 == 0
    if year % 100 == 0
      if year % 400 == 0
        return true
      end
      return false
    end
    return true
  end
  return false
end


# input data block
puts "Enter year"
year = gets.chomp.to_i
puts "enter month"
month = gets.chomp.to_i
puts "enter day"
day = gets.chomp.to_i


#add changin in year_default if leap year
year_default[2] = 29 if leap_year?(year)

#calculate number of day since begining year
day_calc = 0
i = 1
if month > 1
  until i == month
    day_calc += year_default[i]
    i += 1
  end
end
day_calc += day

#Display result
puts "#{day_calc} days since begining #{year} year."
