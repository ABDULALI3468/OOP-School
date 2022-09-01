require_relative 'person'
require_relative 'student'
require_relative 'teacher'
require_relative 'book'
require_relative 'input_module'
require_relative 'classroom'
require_relative 'rental'
require_relative 'store_data'

class App
  include DataStore

  def initialize
    @persons = load_person
    @books = load_book
    @rentals = load_rentals
    @classroom = Classroom.new(1)
  end

  include InputModule

  def add_person
    print 'Do you want to create a student (1) or a teacher (2)? [Input the number]: '
    type = gets.chomp
    print 'Age: '
    age = gets.chomp
    print 'Name: '
    name = gets.chomp

    case type
    when '1'
      write_people('Student', name, age, @persons)
    when '2'
      write_people('Teacher', name, age, @persons)
    else
      puts 'Choose a number from 1 and 2'
    end

    @persons = load_person
    puts 'Person created successfully'
  end

  def print_person
    puts 'The list is empty' if @persons.empty?
    result = ''
    @persons.each_with_index do |person, index|
      result += "#{index}) [#{person['type']}] ID: #{person['ID']}, Name: #{person['name']}, Age: #{person['age']}\n"
    end
    print result
  end

  def create_book
    print 'Title: '
    title = gets.chomp
    print 'Author: '
    author = gets.chomp
    write_books(title, author, @books)
    @books = load_book
    print 'Book created successfully'
  end

  def list_books
    @books.each_with_index do |book, index|
      puts("(#{index})- Title: #{book['title']} , Author: #{book['author']}")
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

    # rental = Rental.new(date, book, person)
    # @rentals << {book: rental.book, person: rental.person, date: rental.date}
    write_rentals(date, book, person, @rentals)
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
      @persons.each { |person| puts "ID : #{person['ID']} => #{person['name']}" }
      puts "\n"
      print "Enter person\'s ID :"
      person = gets.chomp
      puts "\n"
      @rentals.each do |rental|
        if rental['person']['ID'].to_i == person.to_i
          puts "Date : #{rental['date']}, Book \"#{rental['book']['title']}\" by : #{rental['book']['author']}"
        end
      end
    end
  end
end
