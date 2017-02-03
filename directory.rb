require "io/console"
$l = 36
def interactive_menu
  students = []
  loop do
    # 1. print the menu and ask the user what to do
    puts
    puts "1. Input the students".center($l)
    puts "2. Show the students".center($l)
    puts "9. Exit".center($l)


    # 2. read the input and save it into a variable.
    selection = STDIN.noecho(&:gets).sub("\n", "")
    # 3. do what the user asked.
    case selection
      when "1"
        students = input_students
      when "2"
        print_header
        by_cohort(students)
        print_footer(students)
      when "9"
        exit
      else
        puts "I don't know what you meant, try again"
    # 4. repeat from step 1
    end
  end
end


def input_students

  students = []
  name_count, next_student, stdnt = 0, "y", 0

  $arr = [[:name, "Which cohort?:"], [:cohort, "Please check for errors."]]

  until next_student == "n"
    student = {}
    name_count += 1
    count = -1

    err_input = 0
    puts
    puts first_line = "Please enter the name of the student"
    puts
    info = STDIN.noecho(&:gets).sub("\n", "")
    $l = first_line.size

    while count < $arr.size - 1 do
      exit if info == ""
      count += 1
      puts count.even? ? ("#{name_count}. " + info).center($l) : info.center($l)
      puts
      puts ($arr[count][1]).center($l)
      student[($arr[count][0])] = info
      error = "y"

      if count == $arr.size - 1
        until error == "n"
          puts "To corrct an entry just enter".center($l)
          puts "the corresponding number".center($l)
          puts "To exit this option, press ENTER.".center($l)
          puts
          error_num = STDIN.noecho(&:gets).sub("\n", "")
          error_num == "" ? break : error_num = error_num.to_i

          while !(1..$arr.size).include?(error_num)
            puts "Invalid entry. Try again.".center($l)
            error_num = STDIN.noecho(&:gets).sub("\n", "")
            error_num == "" ? break : error_num = error_num.to_i
          end

          break if error_num == ""

          wrong = student[($arr[error_num -1][0])]
          puts
          puts "Changing: #{wrong}".center($l)
          right = STDIN.noecho(&:gets).sub("\n", "")
          student[($arr[error_num - 1][0])] = right
          puts "Changed #{wrong} to #{right}.".center($l)
          puts
          puts "Any more errors? y : n".center($l)
          error = STDIN.noecho(&:gets).sub("\n", "")
          puts error.center($l)
          puts
          until error == "y" || error == "n"
            puts "Invalid entry. Try again.".center($l)
            error = STDIN.noecho(&:gets).sub("\n", "")
            puts error.center($l)
          end
        end
      end
      info = STDIN.noecho(&:gets).sub("\n", "") if count < $arr.size - 1
      if count == $arr.size - 1
        puts
        puts "Add another student? y : n ?".center($l)
        next_student = STDIN.noecho(&:gets).sub("\n", "")

        until next_student == "y" || next_student == "n"
          puts "Invalid entry. Try again.".center($l)
          next_student = STDIN.noecho(&:gets).sub("\n", "")
        end
        puts next_student.center($l)
      end
    end
    students << student
  end
  students
end


def print_header
  puts
  puts "The students of Villains Academy".center($l)
  puts "--------------------------------".center($l)
end


def by_cohort(students)
arr = []
  students.each_with_index do |i, ix|
    month = i[:cohort]
    unless arr.include?(month)

      if ix == 0
        arr << month
        puts
        puts "Students from the #{month} cohort: ".center($l)
      else
        puts
        puts "Students from the #{month} cohort: ".center($l) if !arr.include?(month)
        arr << month
      end

      students.each do |i2|
        if i2[:cohort] == month
          puts ("Name: #{i2[:name]}").center($l)
        end
      end

    end
  end
end


def print_footer(students)
  students.size > 1 ? s = "s" : s = ""
  puts "Overall, we have #{students.count} great student#{s}".center($l)
  puts
end

interactive_menu
students = input_students
print_header
by_cohort(students)
puts
print_footer(students)
