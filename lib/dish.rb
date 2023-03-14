require "monetize"
require "money"

class Dish
    def initialize(name, price)
        @name = name
        @price = price
    end

    def name
        @name
    end

    def price
        if @price.to_i > 0
            return "£#{"%.2f" % @price}"
        else
            fail "Error: please enter a valid price (e.g. an integer)"
        end
    end

    def format_dish
        "#{@name} (#{price})"
    end
end
