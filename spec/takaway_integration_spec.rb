require "dish"
require "menu"
require "takeaway"

RSpec.describe "takeaway integration" do
    it "Initializes with an instance of menu" do
        menu = Menu.new
        dish_1 = Dish.new("Aubergine Curry", 7.5)
        dish_2 = Dish.new("Fennel Pasta", 9)
        menu.add(dish_1)
        menu.add(dish_2)
        takeaway = Takeaway.new(menu, Kernel)
        expect(takeaway.menu.all).to eq [dish_1, dish_2]
    end

    it "recieves the user's order via inputs in terminal" do
        menu = Menu.new
        dish_1 = Dish.new("Aubergine Curry", 7.5)
        dish_2 = Dish.new("Fennel Pasta", 9)
        dish_3 = Dish.new("Pad Thai", 8.5)
        menu.add(dish_1)
        menu.add(dish_2)
        menu.add(dish_3)
        Timecop.freeze(Time.new(2023, 03, 15)) do
            io = double :fake_kernel
            takeaway = Takeaway.new(menu, io)
            expect(io).to receive(:puts).with(
                "Hello. Would you like to see our menu (y/n)?",
            ).ordered
            expect(io).to receive(:gets).and_return("y").ordered
            expect(io).to receive(:puts).with(menu.format_menu).ordered
            expect(io).to receive(:puts).with(
                "Which dish would you like to choose? Please enter the dish number."
                ).ordered
            expect(io).to receive(:gets).and_return("1").ordered
            expect(io).to receive(:puts).with(
                "Thank you. How many of dish 1 would you like to order?",
            ).ordered
            expect(io).to receive(:gets).and_return("1").ordered
            expect(io).to receive(:puts).with(
                "Thank you. Would you like anything else? (y/n)",
            ).ordered
            expect(io).to receive(:gets).and_return("y").ordered
            expect(io).to receive(:puts).with(menu.format_menu).ordered
            expect(io).to receive(:puts).with(
                "Which dish would you like to choose? Please enter the dish number."
                ).ordered
            expect(io).to receive(:gets).and_return("2").ordered
            expect(io).to receive(:puts).with(
                    "Thank you. How many of dish 2 would you like to order?",
                ).ordered
            expect(io).to receive(:gets).and_return("2").ordered
            expect(io).to receive(:puts).with(
                "Thank you. Would you like anything else? (y/n)",
            ).ordered
            expect(io).to receive(:gets).and_return("n").ordered
            expect(io).to receive(:puts).with(
                "Thank you. Please enter your phone number:",
            ).ordered
            expect(io).to receive(:gets).and_return("07527393010").ordered
            expect(io).to receive(:puts).with(
"Thank you. Here is your receipt:
RECEIPT
1. Aubergine Curry (£7.50) x1 = £7.50
2. Fennel Pasta (£9.00) x2 = £18.00
Total = £25.50
END
A confirmation text message has been sent to 07527393010.
Your order should arrive before 00:45
Enjoy your order!"
            ).ordered
            takeaway.place_order
            expect(takeaway.order).to eq (
                [
                        { "count" => 1, "dish" => dish_1 },
                        { "count" => 2, "dish" => dish_2 },
                    ]
            )
        end
    end
end