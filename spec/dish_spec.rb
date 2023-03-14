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
        dish = Dish.new("Aubergine Curry", "£7.50")
        expect(dish.price).to eq "£7.50"
        dish = Dish.new("Pad Thai", "£8.50")
        expect(dish.price).to eq "£8.50"
    end
end
