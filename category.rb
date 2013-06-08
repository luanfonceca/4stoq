class Category
  attr_accessor :id, :name
  @@instance_collector = Array.new

  def initialize(name, id=nil)
    @name = name

    @@instance_collector << self
    @id = @@instance_collector.count
  end

  def to_s
    "Category: ##{@id} #{@name}."
  end

  def self.all
    @@instance_collector
  end

  def self.del(id)
    for category in @@instance_collector
      if category.id == id
        @@instance_collector.delete(category)
      end
    end
  end


  def self.get(id)
    found = nil
    for category in @@instance_collector
      if category.id == id
        found = category
      end
    end
    found
  end

  def self.get_or_create(name)
    found = nil
    for category in @@instance_collector
      if category.name == name
        found = category
      end
    end
    found

    if not found
      found = Category.new(name)
    end

    found
  end
end
