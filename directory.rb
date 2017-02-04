@students = []
$l = 50

def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.sub("\n", ""))
  end
end


def process(selection)
  case selection
    when "1"
     @students = input_students
    when "2"
      show_students
    when "3"
      save_students
    when "4"
      puts "Please supply a filename: ".center($l)
      filename = STDIN.gets.sub("\n", "")
      load_students(filename)
    when "5"
      puts
      puts "Exited program.\n\n".center($l)
      exit
    else
      puts "I don't know what you meant, try again"
  end
end


def print_menu
    puts
    puts "1. Input the students".center($l)
    puts "2. Show the students".center($l)
    puts "3. Save to specified CSV file.".center($l)
    puts "4. Load from specified CSV file.".center($l)
    puts "5. Exit".center($l)
    puts
end


def show_students
  print_header
  print_students_list
  print_footer
end


def load_students(filename = "students.csv")
  file_exists?(filename)
  open(filename, mode= "a+") do |fl|
    fl.readlines.each do |line|
      name, cohort = line.chomp.split(",")
      @students << {name: name, cohort: cohort.to_sym}
    end
  end
  puts
  puts "Successfully loaded from #{filename}".center($l)
end


def file_exists?(filename)
  if filename.empty?
    puts "You entered a blank value. Try again.".center($l)
    interactive_menu
  elsif !File.exists?(filename)
    puts
    puts "Sorry. #{filename} doesn't exist in this directory.".center($l)
    puts
    interactive_menu
  end
end


def try_load_students
  filename = ARGV.first
  return if filename.nil?
  file_exists?(filename)
  load_students(filename)
end


def save_students
  puts "Please supply a filename: ".center($l)
  filename = STDIN.gets.sub("\n", "")
  file_exists?(filename)

  open(filename, mode= "a+") do |fl|
    @students.each do |student|
      student_data = [student[:name], student[:cohort]]
      csv_line = student_data.join(",")
      fl.puts csv_line
    end
    puts "Successfully saved to #{filename}.".center($l)
  end
end


def error_correct
  puts "To correct name, type 'n' then enter".center($l)
  puts "To correct cohort, type 'c' then enter".center($l)
  puts "To exit this option, press ENTER.".center($l)
  puts
end


def input_students
  name_count, error = 0, ""
  $arr = [[:name, "Which cohort?:"], [:cohort, "Please check for errors."]]
  until error == "n"
    student = {}
    name_count += 1
    count = -1
    puts
    puts first_line = "Please enter the name of the student".center($l)
    puts
    info = STDIN.gets.sub("\n", "")
    $l = first_line.size

    while count < $arr.size - 1 do
      if info == ""
        puts "You entered a blank value.\n\n".center($l)
        exit
      end
      count += 1
      puts count.even? ? ("#{name_count}. " + info).center($l) : info.center($l)
      puts
      puts ($arr[count][1]).center($l)
      student[($arr[count][0])] = info
      error = "y"

      if count == $arr.size - 1
        until error == "n"
          error_correct
          error_num = STDIN.gets.sub("\n", "")
          error_num == "" ? break : error_num
          wrong = ""
          invalid_entry(error_num, student)
          wrong = student[($arr[0][0])] if error_num == "n"
          wrong = student[($arr[1][0])] if error_num == "c"

          puts
          puts "Changing: #{wrong}".center($l)
          right = STDIN.gets.sub("\n", "")
          error_num == "n" ? student[($arr[0][0])] = right : student[($arr[1][0])] = right
          puts "Changed #{wrong} to #{right}.".center($l)
          puts
          puts "Any more errors? y : n".center($l)
          error_more = STDIN.gets.sub("\n", "")
          puts
          check = invalid(error_more)
          add_student(student) unless check == "y"
          error = check
        end
      end
      info = STDIN.gets.sub("\n", "") if count < $arr.size - 1
      if count == $arr.size - 1
        add_student(student)
      end
    end
    push_to_arr(student)
 end
 @students
end

def push_to_arr(student)
  @students << student
end


def add_student(student)
  puts
  puts "Add another student? y : n ?".center($l)
  student_error = STDIN.gets.sub("\n", "")
  puts
  invalid(student_error)
  if student_error == "n"
    push_to_arr(student)
    interactive_menu
  else
    push_to_arr(student)
    input_students
  end
end


def invalid(error)
  until error == "y" || error == "n"
    puts "Invalid entry. Try again.".center($l)
    error = STDIN.gets.sub("\n", "")
  end
  error
end


def invalid_entry(error_num, student)
  while !['n', 'c'].include?(error_num)
    puts "Invalid entry. Try again.".center($l)
    error_num = STDIN.gets.sub("\n", "")
    return add_student(student) if error_num == ""
  end
end


def print_header
  puts
  puts "The students of Villains Academy".center($l)
  puts "--------------------------------".center($l)
end


def print_students_list
  arr = []
  @students.each_with_index do |i, ix|
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

     @students.each do |i2|
        if i2[:cohort] == month
          puts ("Name: #{i2[:name]}").center($l)
        end
      end
    end
  end
end


def print_footer
 @students.size != 1 ? s = "s" : s = ""
  puts
  puts "Overall, we have #{@students.count} great student#{s}".center($l)
  puts
end


try_load_students
#load_students #added for Ex.14 No.2
interactive_menu
@students = input_students
print_header
print_students_list
puts
print_footer
