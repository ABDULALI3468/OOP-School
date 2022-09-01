require 'json'
require_relative 'book'
require_relative 'person'

module DataStore
  def write_books(title, author, books)
    books.push({ title: title, author: author, rentals: [] })
    File.write('./books.json', JSON.pretty_generate(books), mode: 'w')
  end

  def load_book
    if File.exist?('books.json')
      JSON.parse(File.read('books.json'))
    else
      []
    end
  end

  def write_people(type, name, age, persons)
    persons.push({ type: type, name: name, age: age, ID: Random.rand(1..1000) })
    File.write('./persons.json', JSON.pretty_generate(persons), mode: 'w')
  end

  def write_rentals(date, book, person, rentals)
    rentals.push({ book: book, person: person, date: date })
    File.write('./rentals.json', JSON.pretty_generate(rentals), mode: 'w')
  end

  def load_person
    if File.exist?('./persons.json')
      JSON.parse(File.read('./persons.json'))
    else
      []
    end
  end

  def load_rentals
    if File.exist?('./rentals.json')
      JSON.parse(File.read('./rentals.json'))
    else
      []
    end
  end
end
