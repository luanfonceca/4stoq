require_relative "product"
require_relative "category"

class ProductActions
  def choices
    """\
+--------------------------------+
|            PRODUCT             |
| [1] - Add a new Product        |
| [2] - Edit a Product           |
| [3] - Delete a Product         |
| [4] - Rel Category - Product   |
| [5] - UnRel Category - Product |
| [6] - List all Products        |"""
  end

  def add
    puts """
+--------------------------------+
|          ADD PRODUCT           |
+--------------------------------+
"""
    puts "Name: "
    @name = gets.chomp
    puts "Description: "
    @description = gets.chomp
    puts "Category: "
    @category = Category.get_or_create(
      gets.chomp
    )

    @product = Product.new(
      @name, @description
    )
    @product.categories.push(
      @category
    )
    puts "Created #{@product}"
  end

  def edit
    puts """
+--------------------------------+
|          EDIT PRODUCT          |
+--------------------------------+
"""
    puts "Get Product by his ID: "
    @product = Product.get(
      gets.chomp.to_i
    )

    puts "Name: (Keep blank to not change.)"
    @new_name = gets.chomp
    if @new_name.length > 0
      @product.name = @new_name
    end

    puts "Description: (Keep blank to not change.)"
    @new_description = gets.chomp
    if @new_description.length > 0
      @product.description = @new_description
    end

    puts "Updated #{@product}"
  end

  def link_category
    puts "Get Product by his ID: "
    @product = Product.get(
      gets.chomp.to_i
    )
    puts "Get the Category by his ID: "
    @product.categories.push(
      Category.get(
        gets.chomp.to_i
      )
    )
    puts "Updated #{@product}"
  end

  def unlink_category
    puts "Get Product by his ID: "
    @product = Product.get(
      gets.chomp.to_i
    )
    puts "Get the Category by his ID: "
    @product.categories.delete(
      Category.get(
        gets.chomp.to_i
      )
    )
    puts "Updated #{@product}"
  end

  def delete
    puts """
+--------------------------------+
|         DELETE PRODUCT         |
+--------------------------------+
"""
    puts "Get Product by his ID: "
    @product = Product.get(
      gets.chomp.to_i
    )
    Product.del(@product.id)
    puts "Deleted #{@product}"
  end

  def list
    puts """
+--------------------------------+
|          LIST PRODUCTS         |
+--------------------------------+
"""
    for product in Product.all
      puts product
    end
  end
end


class CategoryActions
  def choices
    """\
+--------------------------------+
|            CATEGORY            |
| [7] - Add a new Category       |
| [8] - Edit a Category          |
| [9] - Delete a Category        |
| [10] - List all Categories     |
"""
  end

  def add
    puts """
+--------------------------------+
|          ADD CATEGORY          |
+--------------------------------+
"""
    puts "Name: "
    @category = Category.new(
      gets.chomp
    )
    puts "Created #{@category}"
  end

  def edit
    puts """
+--------------------------------+
|          EDIT CATEGORY         |
+--------------------------------+
"""
    puts "Get Category by his ID: "
    @category = Category.get(
      gets.chomp.to_i
    )

    puts "New Name: "
    @new_name = gets.chomp
    @category.name = @new_name

    puts "Updated #{@category}"
  end

  def delete
    puts """
+--------------------------------+
|         DELETE CATEGORY         |
+--------------------------------+
"""
    puts "Get Category by his ID: "
    @category = Category.get(
      gets.chomp.to_i
    )
    Category.del(@category.id)
    puts "Deleted #{@category}"
  end

  def list
    puts """
+--------------------------------+
|        LIST CATEGORIES         |
+--------------------------------+
"""
    for category in Category.all
      puts category
    end
  end
end


class Actions
  attr_accessor :product_actions, :category_actions

  def initialize
    @product_actions = ProductActions.new
    @category_actions = CategoryActions.new
  end

  def choices
    """\n\n
               MENU
+--------------------------------+
|            GENERAL             |
| [0] - Exit                     |
#{@product_actions.choices}
#{@category_actions.choices}\
+--------------------------------+
    \n\n"""
  end
end

class Menu
  attr_accessor :actions

  def initialize
    @actions = Actions.new
  end

  def parse_choice(choice)
    case choice.to_i
      when 0
        exit
      when 1
        actions.product_actions.add
      when 2
        actions.product_actions.edit
      when 3
        actions.product_actions.delete
      when 4
        actions.product_actions.link_category
      when 5
        actions.product_actions.unlink_category
      when 6
        actions.product_actions.list
      when 7
        actions.category_actions.add
      when 8
        actions.category_actions.edit
      when 9
        actions.category_actions.delete
      when 10
        actions.category_actions.list
    end
  end

  def render
    puts @actions.choices
  end
end

class Console
  attr_accessor :menu

  def initialize
    @menu = Menu.new

    while true
      @menu.render
      @menu.parse_choice(gets)
    end
  end
end

Console.new
