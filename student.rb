require_relative 'person'

# Class Student inherits from Person
class Student < Person
  attr_reader :classroom
  def initialize(classroom, age, name, parent_permission)
    super(age, name, parent_permission:parent_permission)

    @classroom = classroom
  end

  def play_hooky
    "¯\(ツ)/¯"
  end
end

# puts Student.new('C1', 30, 'ABC', parent_permission:false).classroom
