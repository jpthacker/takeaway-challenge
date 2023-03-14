class Menu
    def initialize
        @menu = []
    end

    def all
        @menu
    end

    def add(dish)
        @menu << dish
    end

    def format_menu
        def numericised_menu
            menu_with_numbers = []
            for i in 0...@menu.size
                menu_with_numbers << "#{i + 1}. #{@menu[i].format_dish}\n"
            end
            menu_with_numbers.join("")
        end
        "MENU\n#{numericised_menu}END"
    end
end