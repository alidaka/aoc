input = ARGV[0]

floor = 0
value = input.split("").each_with_index do |char, index|
  floor += case char
  when '(' then 1
  when ')' then -1
  else 0
  end

  if floor == -1
    puts index+1
    exit
  end
end

puts -1
