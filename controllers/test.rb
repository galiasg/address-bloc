animals = ['bear', 'tiger', 'penguin', 'zebra']
p "what entry number should I retrive?"
i = gets.chomp.to_i
animals.at(i)
#line 4 is telling the program to throw this away, if I wanted to
#keep it,
p "the #{i} element in the array is #{animals.at(1)}"
