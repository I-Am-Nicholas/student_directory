def input_students
  puts "To move on to a new student hit SPACE, then return"
  puts "To finish, just hit return twice"
  puts "Please enter the name of the first student"

  students = []
  student = {}

  stdnt, cnt = 0, 0

  while cnt < 4 do
    info = gets.chomp
    if cnt == 0
      puts "Name: #{info}"
      student[:name] = info
    elsif cnt == 1
      puts "Enter hobbies: "
      student[:hobbies] = info
    elsif cnt == 2
      puts "Enter favourite food: "
      student[:favourite_food] = info
    elsif cnt == 3
      puts "Enter country of birth: "
      student[:country_of_birth] = info
    elsif info == " "
      puts "Next student"
    end
    cnt += 1
#    info = gets.chomp
  end
  students << student
  students
end


def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

def print(students)
  cnt = 0
  while cnt < students.size
    student = students[cnt]
      puts "#{student[:name]} #{student[:hobbies]} #{student[:favourite_food]} #{student[:country_of_birth]}"
    cnt += 1
  end
end

def print_footer(students)
  puts "Overall, we have #{students.count} great students"
end

students = input_students
print_header
print(students)
print_footer(students)
