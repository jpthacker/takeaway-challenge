require "menu"

RSpec.describe Menu do
    it "initializes with an empty array" do
        menu = Menu.new
        expect(menu.all).to eq []
    end

    it "adds dishes to the menu" do
        menu = Menu.new
        dish_1 = double :fake_dish
        dish_2 = double :fake_dish
        menu.add(dish_1)
        menu.add(dish_2)
        expect(menu.all).to eq [dish_1, dish_2]
    end

    it "returns all the dishes and prices in order" do
        menu = Menu.new
        dish_1 = double :fake_dish, format_dish: "Aubergine Curry (£7.50)"
        dish_2 = double :fake_dish, format_dish: "Fennel Pasta (£9)"
        menu.add(dish_1)
        menu.add(dish_2)
        expect(menu.format_menu).to eq "MENU\n1. Aubergine Curry (£7.50)\n2. Fennel Pasta (£9)\nEND"
        dish_3 = double :fake_dish, format_dish: "Pad Thai (£8.50)"
        menu.add(dish_3)
        expect(menu.format_menu).to eq "MENU\n1. Aubergine Curry (£7.50)\n2. Fennel Pasta (£9)\n3. Pad Thai (£8.50)\nEND"
    end
end