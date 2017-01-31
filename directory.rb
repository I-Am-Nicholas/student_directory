def input_students

	students = []
  next_student, stdnt = "y", 0

  until next_student != "y"
    student = {}
		count = -1
		puts "Please enter the name of the student"
		info = gets.chomp

		while count < 4 do
	    count += 1

    if count == 0
      puts "Which cohort?: "
      student[:name] = info
      elsif count == 1
	      puts "Enter hobbies: "
	      student[:cohort] = info
	    elsif count == 2
	      puts "Enter favourite food: "
	      student[:hobbies] = info
	    elsif count == 3
	      puts "Enter country of birth: "
	      student[:favourite_food] = info
	    elsif count == 4
	      student[:country_of_birth] = info
	    end

	    if count == 4
				puts "Add another student? y : n ?"
				next_student = gets.chomp
			else
				info = gets.chomp
			end
		end

	  students << student
	end
  students
end


def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

def print_stud(students)
  count = 0
  while count != students.size
    student = students[count]
      puts "#{count + 1}. #{student[:name]} from the #{student[:cohort]} cohort likes #{student[:hobbies]} and #{student[:favourite_food]} and was born in #{student[:country_of_birth]}"
    count += 1
  end
end

def print_footer(students)
  students.size > 1 ? s = "s" : s = ""
  puts "Overall, we have #{students.count} great student#{s}"
end

students = input_students
print_header
print_stud(students)
puts
print_footer(students)
