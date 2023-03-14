class Takeaway
    def initialize(menu)
        @menu = menu
        @order = []
    end
    attr_accessor :menu, :order

    def add_to_order(dish, amount)
        amount.times {@order << dish}
    end
end