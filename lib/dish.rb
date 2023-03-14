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
        return @price if @price.is_a?(String) && @price.match?(/\p{Sc}/) && @price.gsub(/\p{Sc}/, "").to_f > 0
        fail "Error: please enter a valid price string"
    end

    def format_dish
        "Fennel Pasta (£9)"
        "#{@name} (#{@price})"
    end
end