require './lib/pantry'
require 'minitest/autorun'
require 'minitest/pride'

class PantryTest < Minitest::Test

  def test_it_exists
    assert_instance_of Pantry, Pantry.new
  end

  def test_access_stock
    pantry = Pantry.new
    empty_hash = {}
    assert_equal empty_hash, pantry.stock
  end

  def test_stock_check
    pantry = Pantry.new
    assert_equal 0, pantry.stock_check("Cheese")
  end

  def test_restock_item
    pantry = Pantry.new
    pantry.restock("Cheese", 10)
    assert_equal 10, pantry.stock_check("Cheese")

    pantry.restock("Cheese", 20)
    assert_equal 30, pantry.stock_check("Cheese")
  end

end