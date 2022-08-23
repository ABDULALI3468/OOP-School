class Person
  attr_reader :id
  attr_accessor :name, :age, :parent_permission
  def initialize(age, name = 'Unknown', parent_permission: true)
    @id = Random.rand(1..1000)
    @name = name
    @age = age
    @parent_permission = parent_permission
  end

  def is_of_age?
    @age >= 18
  end
  private :is_of_age?

  def can_use_services?
    is_of_age? || @parent_permission
  end
  public :can_use_services?

end

person1 = Person.new(18, "ABDUL ALI", parent_permission: false)
puts person1.parent_permission