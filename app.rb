require_relative 'person'
require_relative 'student'
require_relative 'teacher'
require_relative 'book'
require_relative 'input_module'
require_relative 'classroom'
require_relative 'rental'

class App
  def initialize
    @persons = []
    @books = []
    @rentals = []
    @classroom = Classroom.new(1)
  end

  include InputModule

  def display_options
    puts "
      M E N U
      1 - List all books
      2 - List all people
      3 - Create a person
      4 - Create a book
      5 - Create a rental
      6 - List all rentals for a given person id
      7 - Exit
      Please choose an option by entering a number between 1 and 7: "
  end

  def options(input)
    case input
    when 1
      list_books
    when 2
      print_person
    when 3
      add_person
    when 4
      create_book
    when 5
      create_rental
    when 6
      list_rentals
    else
      puts 'You put the wrong input. Please enter a number between 1 and 7.'
    end
  end

  def act_regarding_input
    loop do
      display_options
      choice = gets.to_i
      if choice == 7
        puts 'Thank You for using my School Library!'
        break
      end
      options(choice)
    end
  end

  def add_person
    text = 'Do you want to create a student (1) or a teacher (2)? [Input the number]: '
    type = numeric_input(text, (1..2))

    print 'Age: '
    age = gets.chomp
    print 'Name: '
    name = gets.chomp

    if type == 1
      letter = letter_input('Has parent permission? [Y/N] ', %w[Y N])
      permission = letter == 'Y'
      new_person = Student.new(age, name, permission, @classroom)
    else
      print 'Specialization: '
      specialization = gets.chomp
      new_person = Teacher.new(specialization, age, name, @parent_permission)
    end

    @persons << new_person

    puts 'Person created successfully'
    print @persons
  end

  def print_person
    puts 'People list is empty! Add a person.' if @persons.empty?
    @persons.map do |person|
      p "#{person.class.name} Name: #{person.name}, Age: #{person.age}, id: #{person.id}"
    end
  end

  def create_book
    print 'Title: '
    title = gets.chomp
    print 'Author: '
    author = gets.chomp
    book = Book.new(title, author)
    @books << book
    print 'Book created successfully'
  end

  def list_books
    puts 'Book list is empty! Add a book.' if @books.empty?
    @books.map do |book|
      puts %(Title: "#{book.title}", Author: #{book.author})
    end
  end

  def create_rental
    puts 'Select a book from the following list by number:'
    @books.each_with_index { |book, index| puts %(#{index}\) Title: "#{book.title}", Author: #{book.author}) }
    book_index = gets.chomp.to_i

    @persons.each_with_index do |person, index|
      puts "#{index}) [#{person.class.name}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
    end
    person_index = gets.chomp.to_i

    print 'Date: '
    date = gets.chomp.to_i

    @rentals << Rental.new(date, @books[book_index], @persons[person_index])
    puts 'Rental created sucessfully'
  end

  def list_rentals
    puts "\n"
    if @rentals.empty?
      puts 'No rent is registered in the library'
    else
      puts 'Select a person form the following list by ID'
      @persons.each do |person|
        puts "ID : #{person.id} => #{person.name}"
      end
      puts "

      Enter person\'s ID :"
      person = gets.chomp
      puts "\n"
      @rentals.each do |rental|
        if rental.person.id.to_i == person.to_i
          puts "Date : #{rental.date}, Book \"#{rental.book.title}\" by : #{rental.book.author}"
        end
      end
    end
  end
end
