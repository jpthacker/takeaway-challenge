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

  def prices
    # Returns the title and price of every dish in menu in a readable format
  end

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

  def confirm_order(phone_number) # phone_number is a string of numbers
    # validates the number entered and returns message if invalid
    # sends a text message to number and returns a confirmation message
  end

  def receipt
    # Returns an itemised list of the user's order and the total in a readable format
  end
end

class Menu
  def add(dish) # dish is an instance of Dish
    # dish gets added to the menu
    # Returns nothing
  end

  def prices
    # Returns the title and price of every dish in menu in a readable format
  end
end

class Dish
  def initialize(number, name, price) # number is an integer; name and price are both strings
    # @name = name
    # @price = price
  end

  def validate_dish
    # when Dish is initialized, checks if price is valid and throws error if not
    # also check if title has been used already
  end

  def format
    # Returns a string of the dish and price
  end

  # def select
  #   # adds an instance variable called @selected
  # end
end
```

## 3. Create Examples as Integration Tests

_Create examples of the classes being used together in different situations and
combinations that reflect the ways in which the system will be used._

```ruby
# EXAMPLE

# Gets all tracks
library = MusicLibrary.new
track_1 = Track.new("Carte Blanche", "Veracocha")
track_2 = Track.new("Synaesthesia", "The Thrillseekers")
library.add(track_1)
library.add(track_2)
library.all # => [track_1, track_2]
```

## 4. Create Examples as Unit Tests

_Create examples, where appropriate, of the behaviour of each relevant class at
a more granular level of detail._

```ruby
# EXAMPLE

# Constructs a track
track = Track.new("Carte Blanche", "Veracocha")
track.title # => "Carte Blanche"
```

_Encode each example as a test. You can add to the above list as you go._

## 5. Implement the Behaviour

_After each test you write, follow the test-driving process of red, green,
refactor to implement the behaviour._
