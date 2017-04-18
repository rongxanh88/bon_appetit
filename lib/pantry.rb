require './lib/recipe'
require 'pry'

class Pantry
  attr_accessor :stock, :shopping_list

  def initialize
    @stock = {}
    @shopping_list = {}
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
    shopping_list.each do |food, value|
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

end
