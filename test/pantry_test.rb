require './lib/pantry'
# require './lib/recipe'
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

  def test_shopping_list
    pantry = Pantry.new
    empty = {}

    assert_equal empty, pantry.shopping_list

    recipe = Recipe.new("Cheese Pizza")
    recipe.add_ingredient("Cheese", 20)
    recipe.add_ingredient("Flour", 20)
    pantry.add_to_shopping_list(recipe)

    assert_equal recipe.ingredients, pantry.shopping_list
  end

  def test_a_different_recipe
    recipe = Recipe.new("Spaghetti")
    recipe.add_ingredient("Cheese", 20)
    recipe.add_ingredient("Flour", 20)
    recipe.add_ingredient("Noodles", 10)
    recipe.add_ingredient("Sauce", 10)
    recipe.add_ingredient("Cheese", 5)

    pantry = Pantry.new
    pantry.add_to_shopping_list(recipe)

    expected = {
      "Cheese" => 25, "Flour" => 20, "Noodles" => 10, "Sauce" => 10
    }
    assert_equal expected, pantry.shopping_list
  end

  def test_print_shopping_list
    recipe = Recipe.new("Spaghetti")
    recipe.add_ingredient("Cheese", 20)
    recipe.add_ingredient("Flour", 20)
    recipe.add_ingredient("Noodles", 10)
    recipe.add_ingredient("Sauce", 10)
    recipe.add_ingredient("Cheese", 5)

    pantry = Pantry.new
    pantry.add_to_shopping_list(recipe)
    # pantry.print_shopping_list
    message = "* Cheese: 25\n* Flour: 20\n*" +
              " Spaghetti Noodles: 10\n* Marinara Sauce: 10"
    assert_equal message, pantry.print_shopping_list
  end
end