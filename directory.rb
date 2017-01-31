require "io/console"

def input_students

  students = []
  next_student, stdnt = "y", 0

  arr = [[:name, "Which cohort?: "], [:cohort, "Enter hobbies: "], [:hobbies, "Enter favourite food: "],
        [:favourite_food, "Enter country of birth: "], [:country, "Add another student? y : n ?"]]

  until next_student != "y"
    student = {}
    count = -1

    puts first_line = "Please enter the name of the student"
    info = STDIN.noecho(&:gets).chomp

    while count < 4 do
      count += 1
      puts info.center(first_line.size - 2)
      puts
      puts (arr[count][1]).center(first_line.size)
      student[(arr[count][0])] = info

      if count == 4
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
  puts
  puts "The students of Villains Academy".center(36)
  puts "--------------------------------".center(36)
end

def print_students(students)
  count = 0
  while count != students.size
    student = students[count]
    puts "#{count + 1}. #{student[:name]} from the #{student[:cohort]} cohort".center(36)
    puts "likes #{student[:hobbies]} and #{student[:favourite_food]}".center(36)
    puts "and was born in #{student[:country]}".center(36)
    count += 1
    puts
  end
end

def print_footer(students)
  students.size > 1 ? s = "s" : s = ""
  puts "Overall, we have #{students.count} great student#{s}".center(36)
  puts
end

students = input_students
print_header
print_students(students)
puts
print_footer(students)
