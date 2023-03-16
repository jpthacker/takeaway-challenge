require "dish"
require "menu"

RSpec.describe "menu integration" do
    it "Adds dishes to the menu" do
        menu = Menu.new
        dish_1 = Dish.new("Aubergine Curry", 7.5)
        dish_2 = Dish.new("Fennel Pasta", 9)
        menu.add(dish_1)
        menu.add(dish_2)
        expect(menu.all).to eq [dish_1, dish_2]
    end

    it "Returns the dishes and prices in order" do
        menu = Menu.new
        dish_1 = Dish.new("Aubergine Curry", 7.5)
        dish_2 = Dish.new("Fennel Pasta", 9)
        dish_3 = Dish.new("Pad Thai", 8.5)
        menu.add(dish_1)
        menu.add(dish_2)
        menu.add(dish_3)
        expect(menu.format_menu).to eq (
"MENU
1. Aubergine Curry (£7.50)
2. Fennel Pasta (£9.00)
3. Pad Thai (£8.50)
END"
        )
    end
end