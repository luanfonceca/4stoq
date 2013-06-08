require_relative "../product"
require_relative "../category"

def _create_product
  Product.new("Product name", "Product description")
end

def _create_category
  Category.new("Category name")
end
