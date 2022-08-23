class Person
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
  private :of_age?

  def can_use_services?
    is_of_age? || @parent_permission
  end
  public :can_use_services?
end

puts Person.new(18, 'ABDUL ALI', parent_permission: false).parent_permission