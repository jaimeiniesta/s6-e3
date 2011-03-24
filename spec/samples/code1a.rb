class Person
  def initialize(name)
    @name = name
  end

  def first_name
    @name.split(" ")[0]
  end

  def last_name
    @name.split(" ")[1]
  end
end