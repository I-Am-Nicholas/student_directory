require "io/console"

def input_students

  students = []
  next_student, stdnt = "y", 0

  until next_student != "y"
    student = {}
    count = -1

    puts "Please enter the name of the student"
    info = STDIN.noecho(&:gets).chomp
    puts info.center(36)

    while count < 4 do
      count += 1

    if count == 0
      puts "Which cohort?: ".center(36)
      student[:name] = info
    elsif count == 1
      puts info.center(36)
      puts "Enter hobbies: ".center(36)
      student[:cohort] = info
    elsif count == 2
      puts info.center(36)
      puts "Enter favourite food: ".center(36)
      student[:hobbies] = info
    elsif count == 3
      puts info.center(36)
      puts "Enter country of birth: ".center(36)
      student[:favourite_food] = info
    elsif count == 4
      student[:country_of_birth] = info
    end

    if count == 4
      puts info.center(36)
      puts "Add another student? y : n ?".center(36)
      next_student = STDIN.noecho(&:gets).chomp
      puts next_student.center(36)
    else
      info = STDIN.noecho(&:gets).chomp
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

def print_students(students)
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
print_students(students)
puts
print_footer(students)
