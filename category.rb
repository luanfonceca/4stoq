require_relative "utils"

class Category
  attr_accessor :id, :name, :slug
  @@instance_collector = Array.new

  def initialize(name, id=nil)
    @name = name
    @slug = make_slug(name)

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
    for category in @@instance_collector
      if category.id == id
        return category
      end
    end
  end

  def self.get_or_create(name)
    for category in @@instance_collector
      if category.name == name
        return category
      end
    end

    return Category.new(name)
  end
end
