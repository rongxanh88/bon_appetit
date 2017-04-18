class Pantry
  attr_accessor :stock

  def initialize
    @stock = {}
  end
  
  def stock_check(food)
    if stock[food] != nil
      return stock[food]
    else
      return 0
    end
  end

  def restock(food, amount)
    if stock.has_key?(food)
      previous = stock[food]
      stock[food] = previous + amount
    else
      stock[food] = amount
    end
  end
end
