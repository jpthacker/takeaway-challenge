require "dish"

RSpec.describe Dish do
    it "constructs a dish" do
        dish = Dish.new("Aubergine Curry", 7.5)
        expect(dish.name).to eq "Aubergine Curry"
    end

    it "returns the name of the dish" do
        dish = Dish.new("Pad Thai", 8.5)
        expect(dish.name).to eq "Pad Thai"
    end

    it "validates and returns the price" do
        dish = Dish.new("Aubergine Curry", 7.5)
        expect(dish.format_price).to eq "£7.50"
        dish = Dish.new("Pad Thai", 8.5)
        expect(dish.format_price).to eq "£8.50"
    end

    context "when an invalid string is passed as an argument for price" do
        it "fails" do
            dish = Dish.new("Fennel Pasta", "six")
            expect{ dish.format_price }.to raise_error "Error: please enter a valid price (e.g. an integer)"
            dish = Dish.new("Fennel Pasta", "£7.50")
            expect{ dish.format_price }.to raise_error "Error: please enter a valid price (e.g. an integer)"
        end
    end

    it "formats the name and price of the dish" do
        dish = Dish.new("Aubergine Curry", 7.5)
        expect(dish.format_dish).to eq "Aubergine Curry (£7.50)"
        dish = Dish.new("Fennel Pasta", 9)
        expect(dish.format_dish).to eq "Fennel Pasta (£9.00)"
        dish = Dish.new("Pad Thai", 8.5)
        expect(dish.format_dish).to eq "Pad Thai (£8.50)"
    end
end
