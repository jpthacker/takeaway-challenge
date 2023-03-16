require "takeaway"
require "time"
require "timecop"

RSpec.describe Takeaway do
    it "initializes with an instance of menu" do
        menu = double :fake_menu, all: [1, 2]
        takeaway = Takeaway.new(menu, Kernel)
        expect(takeaway.menu.all).to eq [1, 2]
    end

    it "adds dishes in menu to order a specific number of times" do
        dish_1 = double(:fake_dish, name: "Aubergine Curry")
        dish_2 = double(:fake_dish, name: "Fennel Pasta")
        menu = double :fake_menu, all: [dish_1, dish_2]
        takeaway = Takeaway.new(menu, Kernel)
        takeaway.add_to_order(1, 1)
        expect(takeaway.order).to eq [{ "count" => 1, "dish" => dish_1 }]
        takeaway.add_to_order(2, 3)
        expect(takeaway.order).to eq [
                    { "count" => 1, "dish" => dish_1 },
                    { "count" => 3, "dish" => dish_2 },
                ]
    end

    it "Provides a receipt of order" do
        dish_1 =
            double :fake_dish, format_dish: "Aubergine Curry (£7.50)", price: 7.5
        dish_2 = double :fake_dish, format_dish: "Fennel Pasta (£9.00)", price: 9
        dish_3 = double :fake_dish, format_dish: "Pad Thai (£8.50)", price: 8.5
        menu = double :fake_menu, all: [dish_1, dish_2, dish_3]
        takeaway = Takeaway.new(menu, Kernel)
        takeaway.add_to_order(1, 1)
        takeaway.add_to_order(2, 3)
        takeaway.add_to_order(3, 2)
        expect(takeaway.receipt).to eq(
            "RECEIPT\n1. Aubergine Curry (£7.50) x1 = £7.50\n2. Fennel Pasta (£9.00) x3 = £27.00\n3. Pad Thai (£8.50) x2 = £17.00\nTotal = £51.50\nEND",
        )
    end

    it "Receives inputs from the user" do
        io = double :fake_kernel
        expect(io).to receive(:puts).with(
            "Hello. Would you like to see our menu (y/n)?",
        ).ordered
        expect(io).to receive(:gets).and_return("n").ordered
        expect(io).to receive(:puts).with(
            "Thank you. Please come back another time.",
        ).ordered
        takeaway = Takeaway.new("menu", io)
        takeaway.place_order
    end

    describe "confirm_order_method" do
        it "calculates the estimated delivery time" do
            dish_1 =
                double :fake_dish, format_dish: "Aubergine Curry (£7.50)", price: 7.5
            menu = double :fake_menu, all: [dish_1]
            takeaway = Takeaway.new(menu, Kernel)
            takeaway.add_to_order(1, 1)
            my_number = "07527393010"
            Timecop.freeze(Time.new(2023, 03, 15)) do
                expect(takeaway.confirm_order(my_number)).to eq (
"Thank you. Here is your receipt:
#{takeaway.receipt}
A confirmation text message has been sent to 07527393010.
Your order should arrive before 00:45
Enjoy your order!"
)
            end
        end

        it "validates the user's phone number" do
            dish_1 =
                double :fake_dish, format_dish: "Aubergine Curry (£7.50)", price: 7.5
            menu = double :fake_menu, all: [dish_1]
            takeaway = Takeaway.new(menu, Kernel)
            takeaway.add_to_order(1, 1)
            my_number = "0752739301"
            Timecop.freeze(Time.new(2023, 03, 15)) do
                expect {
                    takeaway.confirm_order(my_number)
                }.to raise_error "Error: please enter a valid number"
                my_number = "075273930156"
                expect {
                    takeaway.confirm_order(my_number)
                }.to raise_error "Error: please enter a valid number"
            end
        end
    end
end
