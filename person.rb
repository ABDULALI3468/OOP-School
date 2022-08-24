require_relative 'decorators'
class Person < Nameable
  attr_reader :id
  attr_accessor :name, :age, :parent_permission

  def initialize(age, name = 'Unknown', parent_permission: true)
    @id = Random.rand(1..1000)
    @name = name
    @age = age
    @parent_permission = parent_permission
  end

  def of_age?
    @age >= 18
  end

  def can_use_services?
    of_age? || @parent_permission
  end

  def correct_name
    @name
  end

  private :of_age?
end

person = Person.new(22, 'maximilianus')
person.correct_name
capitalizedPerson = CapitalizeDecorator.new(person)
puts capitalizedPerson.correct_name
capitalizedTrimmedPerson = TrimmerDecorator.new(capitalizedPerson)
puts capitalizedTrimmedPerson.correct_name
