input = ARGV[0]
value = input.split("").inject(0) do |acc, char|
  acc + case char
  when '(' then 1
  when ')' then -1
  else 0
  end
end

puts value
