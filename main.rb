require_relative 'app'
require_relative 'input_module'

class Main
  attr_reader :app

  def initialize
    @app = App.new
  end

  include InputModule

  def display_options
    "
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
      app.list_books
    when 2
      app.print_person
    when 3
      app.add_person
    when 4
      app.create_book
    when 5
      app.create_rental
    when 6
      app.list_rentals
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

  def run
    puts "Welcome to the School Library app!\n"
    menu
    puts 'Thank you for using this app!'
  end
end

main = Main.new
main.run
