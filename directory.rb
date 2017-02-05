require 'csv'
@students = []
@l = 75


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
      wipe?
    when "5"
      own_source
    when "6"
      puts "Exited the program.\n\n".center(@l)
      exit
    else
      puts "I don't know what you meant. Try again.\n".center(@l)
  end
end


def print_menu
    puts
    puts "1. Input the students".center(@l)
    puts "2. Show the students".center(@l)
    puts "3. Save to specified CSV file.".center(@l)
    puts "4. Load from specified CSV file.".center(@l)
    puts "5. View source code?".center(@l)
    puts "6. Exit\n".center(@l)
end


def show_students
  print_header
  print_students_list
  print_footer
end


def supply_filename
  puts
  puts "Please supply a filename: \n".center(@l)
end

def try_load_students
  filename = ARGV.first
  file_exists?(filename)
  load_students(filename) unless filename.nil?
end


def load_students(filename = "students.csv")
  filename.nil? ? filename = "students.csv" : file_exists?(filename)
  CSV.foreach(filename, "r") do |fl|
    @students << {name: fl[0], cohort: fl[1].to_sym}
  end
  puts
  puts "Successfully loaded from #{filename}".center(@l)
end


def save_students
  supply_filename
  filename = STDIN.gets.sub("\n", "")
  file_exists?(filename)
  CSV.open(filename, "w") do |csv|
    @students.each do |student|
      csv << [student[:name], student[:cohort]]
    end
  end
  puts "Successfully saved to #{filename}.".center(@l)
end


def file_exists?(filename)
  if filename.nil?
    load_students
  elsif filename.empty?
    puts "You entered a blank value.".center(@l)
    puts "Select and try again.".center(@l)
    interactive_menu
  elsif !File.exists?(filename)
    puts
    puts "Sorry. #{filename} doesn't exist in this directory.\n".center(@l)
    interactive_menu
  elsif File.exist?(filename)
    return
  end
end


def wipe?
  print_wipe
  wipe = STDIN.gets.sub("\n", "")
  if yes_no?(wipe) == "y"
    @students.clear
    "Deleted.".center(@l)
    supply_filename
    filename = STDIN.gets.sub("\n", "")
    load_students(filename)
  else
    interactive_menu
  end
end


def print_wipe
  puts "This will overwrite the current list in memory.".center(@l)
  puts "The original file will be unaffected.".center(@l)
  puts "Go ahead? y : n\n".center(@l)
end


def print_check
  puts "To correct name, type 'n' then enter".center(@l)
  puts "To correct cohort, type 'c' then enter".center(@l)
  puts "To exit this option, press ENTER.\n".center(@l)
end


def input_students
  name_count, error = 0, ""
  $arr = [[:name, "Which cohort?:"], [:cohort, "Please check for errors."]]
  $sz = $arr.size - 1
  until error == "n"
    student = {}
    name_count += 1
    count = -1
    puts
    puts "Please enter the name of the student\n".center(@l)
    info = STDIN.gets.sub("\n", "")

    while count < $sz do
      blank_value(info)
      count += 1
      puts info.center(@l)
      puts
      puts ($arr[count][1]).center(@l)
      student[($arr[count][0])] = info
      error = "y"
      correct?(error, student) if count == $sz
      info = STDIN.gets.sub("\n", "") if count < $sz
      add_student(student) if count == $sz
    end
    push_to_arr(student)
 end
 @students
end


def main_error_check(error_num, student)
  while !['n', 'c', ""].include?(error_num)
    invalid
    error_num = STDIN.gets.sub("\n", "")
  end
  add_student(student) if error_num == ""
  error_num == "n" ? correcting = 0 : correcting = 1
  wrong = student[($arr[correcting][0])]
  puts
  puts "Changing: #{wrong}".center(@l)
  right = STDIN.gets.sub("\n", "")
  error_num == "n" ? student[($arr[0][0])] = right : student[($arr[1][0])] = right
  puts "Changed #{wrong} to #{right}.".center(@l)
end


def blank_value(info)
  if info == ""
    puts "You entered a blank value.\n\n".center(@l)
    exit
  end
end


def push_to_arr(student)
  @students << student
end


def add_student(student)
  puts
  puts
  puts "Add another student? Enter y : n".center(@l)
  student_error = STDIN.gets.sub("\n", "")
  puts
  if !["y", "n"].include?(student_error)
    invalid
    add_student(student)
  end
  if student_error == "n"
    push_to_arr(student)
    interactive_menu
  else
    push_to_arr(student)
    input_students
  end
end


def correct?(error, student)
  until error == "n"
    print_check
    error_num = STDIN.gets.sub("\n", "")
    add_student(student) if error_num == ""
    main_error_check(error_num, student)
    puts
    puts "Any more errors? y : n".center(@l)
    error_more = STDIN.gets.sub("\n", "")
    puts
    check = yes_no?(error_more)
    add_student(student) unless check == "y"
    error = check
  end
end


def yes_no?(error)
  until error == "y" || error == "n"
    invalid
    error = STDIN.gets.sub("\n", "")
  end
  error
end


def invalid
  puts "Invalid entry. Try again.".center(@l)
end


def print_header
  puts
  puts "The students of Villains Academy".center(@l)
  puts "--------------------------------".center(@l)
end


def print_students_list
  arr = []
  @students.each_with_index do |i, ix|
    month = i[:cohort]
    unless arr.include?(month)

      if ix == 0
        arr << month
        puts
        puts "Students from the #{month} cohort: ".center(@l)
      else
        puts
        puts "Students from the #{month} cohort: ".center(@l) if !arr.include?(month)
        arr << month
      end

      @students.each_with_index do |i2, idx|
        if i2[:cohort] == month
          puts ("#{idx + 1}. #{i2[:name]}").center(@l)
        end
      end
    end
  end
end


def print_footer
 @students.size != 1 ? s = "s" : s = ""
  puts
  puts "Overall, we have #{@students.count} great student#{s}".center(@l)
  puts
end


def own_source
  open(__FILE__){|r| puts (r.read)}
end


try_load_students
interactive_menu
@students = input_students
print_header
print_students_list
puts
print_footer
