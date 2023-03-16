require_relative "sms.rb"

class Takeaway
    def initialize(menu, io)
        @menu = menu
        @order = []
        @io = io
    end
    attr_accessor :menu, :order

    def add_to_order(dish_no, amount)
        amount.times do 
            current_dish = @menu.all[dish_no - 1]
            if @order.any? {|dish| dish["dish"] == current_dish}
                @order.each {|dish| dish["count"] += 1 if dish["dish"] == current_dish}
            else
                @order << {"dish" => current_dish, "count" => 1}
            end
        end
    end

    def receipt
        @total_cost = 0
        def itemised_receipt
            itemised_order = []
            for i in 0...@order.size
                formatted_dish = @order[i]["dish"].format_dish
                cost_of_dish = @order[i]["dish"].price * @order[i]["count"]
                dish_count = @order[i]["count"]
                itemised_order << "#{i + 1}. #{formatted_dish} x#{dish_count} = #{format_price(cost_of_dish)}\n"
                @total_cost += cost_of_dish
            end
            itemised_order.join("")
        end
        "RECEIPT\n#{itemised_receipt}Total = #{format_price(@total_cost)}\nEND"
    end

    def place_order
        @io.puts "Hello. Would you like to see our menu (y/n)?"
        input = @io.gets.chomp
        @io.puts "Thank you. Please come back another time."
    end

    def confirm_order(user_phone_number)
        # sms = SMS.new(Twilio::REST::Client)
        # sms.send(user_phone_number, get_time)
"Thank you. Here is your receipt:
#{receipt}
A confirmation text message has been sent to #{validate_phone_number(user_phone_number)}.
Your order should arrive before #{get_time}
Enjoy your order!"
    end

    private 

    def format_price(cost)
        "£#{"%.2f" % cost}"
    end

    def validate_phone_number(phone_number)
        check = phone_number.match?(/0[0-9]{10}/) && phone_number.length == 11
        return phone_number if check
        fail "Error: please enter a valid number"
    end

    def get_time
        t_1 = Time.now
        t_2 = t_1 + 45 * 60
        return t_2.strftime("%H:%M")
    end
end

# takeaway = Takeaway.new("menu", Kernel)
# takeaway.confirm_order("07527393010")