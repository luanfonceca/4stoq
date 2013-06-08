require_relative "category"

class Product
  attr_accessor :id, :name, :description, :categories
  attr_reader :categories
  @@instance_collector = Array.new

  def initialize(name, description, id=nil)
    @name = name
    @description = description
    @categories = Array.new

    @@instance_collector << self
    @id = @@instance_collector.count
  end

  def to_s
    "Product: ##{@id} #{@name}, #{@description}, #{@categories}."
  end

  def self.del(id)
    for product in @@instance_collector
      if product.id == id
        @@instance_collector.delete(product)
      end
    end
  end

  def self.get(id)
    found = nil
    for product in @@instance_collector
      if product.id == id
        found = product
      end
    end
    found
  end

  def self.all
    @@instance_collector
  end
end
