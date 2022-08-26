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
    return 'No people to list' if @persons.empty?

    result = ''
    @persons.each_with_index do |person, index|
      result += "#{index}) [#{person.class.name}] ID: #{person.id}, Name: #{person.name}, Age: #{person.age}\n"
    end
    print result
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
    i = 0
    while i < @books.length
      puts "#{i}) Title: #{@books[i].title}, Author: #{@books[i].author}"
      i += 1
    end
  end

  def create_rental
    select_books = 'Select a book from the following list by number '
    puts select_books
    list_books
    book_index = gets.chomp.to_i
    puts 'Select a person from the following list by number (not id)'
    print_person
    person_index = gets.chomp.to_i
    print 'Date: '

    date = gets.chomp.to_i
    person = @persons[person_index]
    book = @books[book_index]

    @rentals << Rental.new(date, book, person)
    puts 'Rental created sucessfully'
  end

  def person_by_id
    loop
    print 'ID of person: '
    id = gets.chomp.to_i

    @people.each_with_index do |person, index|
      return index if person.id == id
    end
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
      puts "\n"
      print "Enter person\'s ID :"
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
