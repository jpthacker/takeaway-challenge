# Takeaway Design Recipe

## 1. User Story

> As a customer  
> So that I can check if I want to order something  
> I would like to see a list of dishes with prices.
>
> As a customer  
> So that I can order the meal I want  
> I would like to be able to select some number of several available dishes.
>
> As a customer  
> So that I can verify that my order is correct  
> I would like to see an itemised receipt with a grand total.

The problem below requires the `twilio-ruby` gem and the use of doubles.

> As a customer  
> So that I am reassured that my order will be delivered on time  
> I would like to receive a text such as "Thank you! Your order was placed and
> will be delivered before 18:52" after I have ordered.

## 2. The Class System

```ruby
class Takeaway
  def initialize
    # ... Takeaway intitializes with an instance of Menu
    # and an empty array of selected dishes (order)
  end
  attr_accessor :menu :order

  # def prices
  #   # Returns the title and price of every dish in menu in a readable format
  # end

  def place_order
    # Runs the takaway bot (puts/gets)
    # Prints the menu to the terminal
    # Gets the dish and amount from user
    # Repeats the process until the user confirms their choices
    # Gets the user's phone number (stroes it in an instance variable)
    # Runs confirm_order and sends message
    # Prints a confirmation message
    # Asks user if they would like a receipt
    # Returns a receipt if y
    # End with before or after receipt
  end

  def add_to_order(number, amount)
    # Adds the corresponding dish to order amount times
  end

  def confirm_order(phone_number) # phone_number is a string of numbers
    # validates the number entered and returns message if invalid
    # sends a text message to number and returns a confirmation message
    # Uses twilio

    private 

    def validate_phone_number(phone_number)
      # validates the number entered
    end

    def calculate_time(current_time)
      #returns a string of the time in 45 minutes
    end
  end

  def receipt
    # Returns an itemised list of the user's order and the total in a readable format
  end
end

class Menu
  def initialize
    # initializes with a menu as an empty array
  end

  def add(dish) # dish is an instance of Dish
    # dish gets added to the menu
    # Returns nothing
  end

  def all
    # Returns @menu
  end

  def format_menu
    # Returns the title and price of every dish in the menu in a readable format
  end
end

class Dish
  def initialize(name, price) # name and price are both strings
    # @name = name
    # @price = price
  end

  def validate_dish
    # when Dish is initialized, checks if price is valid and throws error if not
  end

  def name
    # returns @name
  end

  def price
    # returns @price in a price format as a string
  end

  def format_dish
    # Returns a string of the dish and price
  end

  # def select
  #   # adds an instance variable called @selected
  # end
end
```

## 3. Examples as Integration Tests

```ruby
# MENU

# Adds dishes to menu
menu = Menu.new
dish_1 = Dish.new("Aubergine Curry", 7.5)
dish_2 = Dish.new("Fennel Pasta", 9)
menu.add(dish_1)
menu.add(dish_2)
menu.all # => [dish_1, dish_2]

# Returns all the dishes and prices in order
menu = Menu.new
dish_1 = Dish.new("Aubergine Curry", 7.5)
dish_2 = Dish.new("Fennel Pasta", 9)
dish_3 = Dish.new("Pad Thai", 8.5)
menu.add(dish_1)
menu.add(dish_2)
menu.add(dish_3)
menu.format_menu # => ... 
# "MENU
# 1. Aubergine Curry (£7.50)
# 2. Fennel Pasta (£9)
# 3. Pad Thai (£8.50)
# END"

# TAKEAWAY

# Initializes with an instance of menu
menu = Menu.new
dish_1 = Dish.new("Aubergine Curry", 7.5)
dish_2 = Dish.new("Fennel Pasta", 9)
menu.add(dish_1)
menu.add(dish_2)
takeaway = Takeaway.new(menu)
takeaway.menu.all = [dish_1, dish_2]

# Receives the order from the customer
menu = Menu.new
takeaway = Takeaway.new(menu)
dish_1 = Dish.new("Aubergine Curry", 7.5)
dish_2 = Dish.new("Fennel Pasta", 9)
dish_3 = Dish.new("Pad Thai", 8.5)
takeaway.menu.add(dish_1)
takeaway.menu.add(dish_2)
takeaway.menu.add(dish_3)
takeaway.add_to_order(dish_1, 1)
takeaway.add_to_order(dish_2, 3)
takeaway.add_to_order(dish_3, 2)
takeaway.place_order # => ...

# Hello. Would you like to see our menu (y/n)?
# y
# MENU
# 1. Aubergine Curry (£7.50)
# 2. Fennel Pasta (£9)
# 3. Pad Thai (£8.50)
# END
# Which dish would you like to choose: 1, 2, or 3?
# 1
# Thank you. How many of dish 1 would you like to order?
# 1
# Thank you. Would you like anything else? (y/n)
# y
# MENU
# 1. Aubergine Curry (£7.50)
# 2. Fennel Pasta (£9)
# 3. Pad Thai (£8.50)
# END
# Which dish would you like to choose: 1, 2, or 3?
# 2
# Thank you. How many of dish 2 would you like to order?
# 2
# Thank you. Would you like anything else? (y/n)
# n
# Thank you. Please enter your phone number:
# 07527393010
# Thank you. Here is your receipt:
# RECEIPT
# Aubergine Curry (£7.50)
# Fennel Pasta x2 (£18)
# Total = £25.50
# END
# A confirmation text message has been sent to 07527393010.
# Enjoy your order!
```

## 4. Examples as Unit Tests

```ruby
# DISH

# Constructs a dish
dish = Dish.new("Aubergine Curry", 7.5)
dish.name # => "Aubergine Curry"

# Returns the name of the dish
dish = Dish.new("Pad Thai", 8.5)
dish.price # => "£7.50"

# Returns the price in the correct format
dish = Dish.new("Aubergine Curry", 7.5)
dish.price # => "£7.50"
dish = Dish.new("Pad Thai", 8.5)
dish.price # => "£8.50"

# Validates the price
dish = Dish.new("Fennel Pasta", "lots")
# => throws error "Error: please enter a valid price string"

# Formats the name and price of the dish
dish = Dish.new("Fennel Pasta", 9)
dish.format_dish # => "Fennel Pasta (£9)"

# MENU

# Initializes with an empty array
menu = Many.new
menu.all # => []

# Adds dishes to menu
menu = Menu.new
dish_1 = double :fake_dish
dish_2 = double :fake_dish
menu.add(dish_1)
menu.add(dish_2)
menu.all # => [dish_1, dish_2]

# Returns all the dishes and prices in order
menu = Menu.new
dish_1 = double :fake_dish, format: "Aubergine Curry (£7.50)"
dish_2 = double :fake_dish, format: "Fennel Pasta (£9)"
dish_3 = double :fake_dish, format: "Pad Thai (£8.50)"
menu.add(dish_1)
menu.add(dish_2)
menu.add(dish_3)
menu.format_menu # => ... 
# "MENU
# 1. Aubergine Curry (£7.50)
# 2. Fennel Pasta (£9)
# 3. Pad Thai (£8.50)
# END"

# TAKEAWAY

# Initializes with an instance of menu
menu = double :fake_menu, all: [1, 2]
takeaway = Takeaway.new(menu)
takeaway.menu.all # => [1, 2]

# Adds dishes in menu to order a specific number of times
menu = double :fake_menu
takeaway = Takeaway.new(menu)
dish_1 = double :fake_dish
dish_2 = double :fake_dish
takeaway.menu.add(dish_1)
takeaway.menu.add(dish_2)
takeaway.add_to_order(dish_1, 1)
takeaway.order # => [dish_1]
takeaway.add_to_order(dish_2, 3)
takeaway.order # => [dish_1, dish_2, dish_2, dish_2]

# Provides a receipt of order
menu = double :fake_menu
takeaway = Takeaway.new(menu)
dish_1 = double :fake_dish, format: "Aubergine Curry (£7.50)"
dish_2 = double :fake_dish, format: "Fennel Pasta (£9)"
dish_3 = double :fake_dish, format: "Pad Thai (£8.50)"
takeaway.add_to_order(dish_1, 1)
takeaway.add_to_order(dish_2, 3)
takeaway.add_to_order(dish_3, 2)
takeaway.receipt # => ...
# "RECEIPT
# Aubergine Curry (£7.50)
# Fennel Pasta x3 (£27)
# Pad Thai x2 (£17)
# Total = £51.50
# END"

# Receives yes or no answers from the user
menu = double :fake_menu
takeaway = Takeaway.new(menu)
dish_1 = double :fake_dish, format: "Aubergine Curry (£7.50)"
takeaway.add_to_order(dish_1, 1)
takeaway.place_order # => ...

# Hello. Would you like to see our menu (y/n)?
# n
# Thank you. Please come back another time. 

# validates the phone number of the user
menu = double :fake_menu
takeaway = Takeaway.new(menu)
takeaway.confirm_order(07537393010) # => ...
"Thank you. Here is your receipt:
RECEIPT
Aubergine Curry (£7.50)
Fennel Pasta x2 (£18)
Total = £25.50
END
A confirmation text message has been sent to 07527393010.
Your order should arrive before [45 mins from current time]
Enjoy your order!"

# ... and sends a similarly worded text message to 07527393010
```