require_relative 'person'

# Class Student inherits from Person
class Student < Person
  def initialize(classroom, age, name, parent_permission)
    super(age, name, parent_permission: parent_permission)

    @classroom = classroom
  end

  def play_hooky
    "¯\(ツ)/¯"
  end

  def classroom=(classroom)
    @classroom = classroom
    classroom.students.push(self) unless classroom.students.include?(self)
  end
end

# puts Student.new('C1', 30, 'ABC', parent_permission:false).classroom
