require 'test/unit'

require_relative "../category"


class TestCategory < Test::Unit::TestCase
  attr_accessor :category

  def setup
    @category = Category.new("Category name")
  end

  def teardown
    Category.all.clear
  end

  def test_add
    assert_equal(
      category.to_s,
      "Category: #1 Category name."
    )
  end

  def test_all
    Category.new(
      "Second Category"
    )

    assert_equal(
      Category.all.count,
      2
    )
  end

  def test_get
    category = Category.get(1)

    assert_equal(
      category.to_s,
      "Category: #1 Category name."
    )
    assert_equal(
      Category.all.count,
      1
    )
  end

  def test_del
    Category.new(
      "Second Category"
    )

    Category.del(1)
    assert_equal(
      Category.all.count,
      1
    )
  end

  def test_get_or_create
    category = Category.get_or_create("Second name")

    assert_equal(
      category.to_s,
      "Category: #2 Second name."
    )
    assert_equal(
      Category.all.count,
      2
    )
  end
end
