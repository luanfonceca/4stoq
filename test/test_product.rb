require 'test/unit'
require_relative "../product"
require_relative "../category"


class TestProduct < Test::Unit::TestCase
  attr_accessor :product, :category

  def setup
    @product = Product.new(
      "Product name", "Product description"
    )
    @category = Category.new("Category name")
  end

  def teardown
    Product.all.clear
    Category.all.clear
  end

  def test_add
    assert_equal(
      @product.to_s,
      "Product: #1 Product name, "\
      "Product description, []."
    )
  end

  def test_all
    Product.new(
      "Second Product", "Product description"
    )

    assert_equal(
      Product.all.count,
      2
    )
  end

  def test_get
    Product.new(
      "Second Product", "Product description",
    )

    product = Product.get(1)
    assert_equal(
      product.to_s,
      "Product: #1 Product name, "\
      "Product description, []."
    )
    assert_equal(
      Product.all.count,
      2
    )
  end

  def test_del
    Product.new(
      "Second Product", "Product description",
    )

    Product.del(1)
    assert_equal(
      Product.all.count,
      1
    )
  end

  def test_add_category
    @product.categories.push(@category)

    assert_equal(
      @product.to_s,
      "Product: #1 Product name, "\
      "Product description, "\
      "[Category: #1 Category name.]."
    )
  end

  def test_remove_category
    self.test_add_category

    @product.categories.delete(@category)
    assert_equal(
      @product.to_s,
      "Product: #1 Product name, "\
      "Product description, []."
    )
  end

  def test_add_many_categories
    self.test_add_category

    @product.categories.push(
      Category.new("Another Category")
    )

    assert_equal(
      @product.to_s,
      "Product: #1 Product name, "\
      "Product description, "\
      "[Category: #1 Category name., "\
      "Category: #2 Another Category.]."
    )
  end

end
