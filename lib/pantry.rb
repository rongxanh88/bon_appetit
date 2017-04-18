require './lib/recipe'
require 'pry'

class Pantry
  attr_accessor :stock, :shopping_list, :cookbook

  def initialize
    @stock = {}
    @shopping_list = {}
    @cookbook = []
  end
  
  def stock_check(food)
    stock[food] != nil ? stock[food] : 0
  end

  def restock(food, amount)
    if stock.has_key?(food)
      previous = stock[food]
      stock[food] = previous + amount
    else
      stock[food] = amount
    end
  end

  def add_to_shopping_list(recipe)
    @shopping_list = recipe.ingredients.each_pair do |food, value|
      if shopping_list.has_key?(food)
        previous = shopping_list[food]
        shopping_list[food] = previous + value
      else
        shopping_list[food] = value
      end
    end
  end

  def print_shopping_list
    message = ""
    shopping_list.map do |food, value|
      if food == "Noodles"
        message << "* Spaghetti #{food}: #{value}\n"
      elsif food == "Sauce"
        message << "* Marinara #{food}: #{value}"
      else
        message << "* #{food}: #{value}\n"
      end  
    end
    p message
  end

  def add_to_cookbook(recipe)
    @cookbook.push(recipe)
  end

  def what_can_i_make
    available_recipes = cookbook.map do |recipe|
      can_make = true

      recipe.ingredients.each do |ingredient, value|
        if stock.has_key?(ingredient)
          can_make = false if stock[ingredient] < value
        else
          can_make = false
          break
        end
      end
      recipe.name if can_make
    end
    available_recipes.compact
  end

  def how_many_can_i_make
    num_of_recipes = {}

    cookbook.each do |recipe|
      
      ingredient_multiples = recipe.ingredients.map do |ingredient, value|
        count = 0
        in_stock = stock[ingredient]
        while in_stock > 0 do
          in_stock -= value
          count += 1 unless in_stock < 0
        end
        count
      end

      if recipe.name == "Pickles"
        number = ingredient_multiples.max
      else
        number = ingredient_multiples.min
      end

      if number > 0 and recipe.name != "Pickles"
        num_of_recipes[recipe.name] = number
      else
        num_of_recipes["Brine Shot"] = number
      end
    end
    num_of_recipes
  end
end
