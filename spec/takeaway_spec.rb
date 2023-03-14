require "takeaway"

RSpec.describe Takeaway do
    it "initializes with an instance of menu" do
        menu = double :fake_menu, all: [1, 2]
        takeaway = Takeaway.new(menu)
        expect(takeaway.menu.all).to eq [1, 2]
    end

    it "adds dishes in menu to order a specific number of times" do
        menu = double :fake_menu, all: [1, 2]
        takeaway = Takeaway.new(menu)
        takeaway.add_to_order(1, 1)
        expect(takeaway.order).to eq [1]
        takeaway.add_to_order(2, 3)
        expect(takeaway.order).to eq [1, 2, 2, 2]
    end
end