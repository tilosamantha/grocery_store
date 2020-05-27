##### Objective #####
# See Store -> def: store
# Add Item -> def: add_cart
# Remove Item -> def: remove_item
# View Cart -> def: view_cart
# Add to Store -> def: add_store

 #create grocery store = []
  #noodles
  #marinera sauce
  #parmasean
  #meatballs
  #salt
  #pepper
#customer cart = []
#user option menu
  #add item
  #remove item
  #show entire cart
  #show the cost of cart
  #add new items to store

  @store = [
    {item: "noodles", price: 500.00},
    {item: "marinera sauce", price: 250.00},
    {item: "parmasean", price: 50.50},
    {item: "meatball", price: 1000.00},
    {item: "salt", price: 100.00},
    {item: "pepper", price: 101.00}
  ]
  
  @cart = []
  @wallet = 50000.00
  
  puts "\nHello! Welcome to our Million Dollar Store!\n"
  

  def menu
    seperator
    puts "What would you like to do?"
    puts "1) Add item to your cart"
    puts "2) Remove item from your cart"
    puts "3) See what's in your cart"
    puts "4) See the total price"
    puts "5) Add an item to the grocery store"
    puts "6) Exit"
  end
  

  def user_selection
    choice = gets.to_i
    case choice
    when 1
      add_cart
      menu
    when 2
      remove_item
      menu
    when 3
      view_cart
      menu
    when 4
      cart_cost
      coupon
      check_out
      menu
    when 5
      add_store
      menu
    when 6
      puts "\nHave a good day!"
      exit
    else
      puts "Invalid Input. Try Again"
      menu
    end
    
    user_selection
  end
  
  
  def see_store 
    puts "Available items for purchase: (Please input number)\n"
    @store.each_with_index do |food, index| 
      puts "#{index + 1} #{food[:item]} $#{food[:price]}"
    end
  end
  
  
  def add_cart
    seperator
    items = see_store
    choice = gets.to_i
    if choice > 0 && choice <= items.length
      item = items[choice - 1]
    else
      puts "Invalid input. Try again"
      add_cart
    end
    
    @cart << item
  end
  
  
  def add_store
    seperator
    items = Hash.new()
    puts "Enter the item and price you want to add to the store:"
    puts "(Use the following format: 'item<space>price')"
    new_food = gets.split(" ")
    items[:item] = new_food.first
    items[:price] = new_food.last.to_f
    
    @store << items
  end
  
  
  def remove_item
    seperator
    puts "What would you like to remove? (Please input number):"
    view_cart
    choice = gets.to_i
    if choice > 0 && choice <= @cart.length
      item = @cart.delete_at(choice - 1)
    else
      puts "Invalid input. Try again"
      remove_item
    end
    puts "This is what you have left in your cart:"
    view_cart
  end
  
  ### Delete multiple items from cart ###
  #user input (string)
  #empty array choice []
  #split input by "spaces" --> multiple inputs
  #turn into integer
  #if user input = food[:index] THEN remove item from @cart

  
  def view_cart
    seperator
    puts "Here's what you have in your cart right now: "
    @cart.each_with_index do |food, index| 
      puts "#{index + 1} #{food[:item]} $#{food[:price]}"
    end
  end


  def cart_cost
    seperator
    puts "This is the total cost of the items in your cart: "
    cost = 0
    
    @cart.each_with_index do |food, index|
      cost += food[:price]
    end  
    puts "$ #{'%.2f'%cost.round(2)}"

    seperator
    
    puts "Total cost after taxes: "
    tax = cost * 0.25
    taxed = cost + tax
    puts "$ #{'%.2f'%taxed.round(2)}"
    
    seperator

    # puts "This is how much money you would have left: "
    # @wallet = @wallet - taxed
    # puts "$#{@wallet}"
  end
  

  def check_out
    seperator

    puts "Are you ready to check out? (yes/no)"
    choice = gets.chomp
    cost = 0

    case choice
      when 'yes'                                        
        @cart.each_with_index do |food, index|          
          cost += food[:price]
          puts "#{food[:item].ljust(10)} - $#{food[:price]}"        #this doesn't line up nicely like I want it to
        end
        tax = cost * 0.25
        total_price = cost + tax
        puts "-------------------"
        puts "tax:          $#{tax}"      
        puts "total:        $#{'%.2f'%total_price.round(2)}"

        wallet = @wallet
        wallet = wallet - total_price

        seperator

        puts "After your purchase you have #{'%.2f'%wallet.round(2)} left."
        puts "Thanks for shopping!"
        exit
      else
        menu
    end
  end

  def coupon
    seperator

    puts "We have a special deal happening now! Spend more than $2000 and take an extra 30% off your purchase!"
    cost = 0
    
    @cart.each_with_index do |food, index|                                        #get the cost of the cart
      cost += food[:price]
    end

    if cost > 2000.00
      puts "Yay! You qualify for the coupon! Your total is now: "                 #dont factor in taxes yet
      discount = cost * 0.3                                                       #do that at checkout
      cost = cost - discount
      puts "$#{'%.2f'%cost.round(2)}"
    else
      puts "Sorry, it looks like this doesn't apply to you...."
    end
  end
                                                      

  def seperator
    puts "\n"
    puts "*" * 10
    puts "\n"
  end
  

  menu
  user_selection


# Allow a user to remove multiple items at once from the cart.
# ------------------- Assign the user an amount of money to start.
# ------------------- Give the user the option to "Check out".
# If they have enough money, their cart gets cleared and money is subtracted.
# If they don't have enough money, they have to delete items.
# ------------------- Apply some sort of coupon system.
# ------------------- For example, a 20% off coupon that takes the price of all items down by 20%.
# ------------------- Apply taxes to transaction.
# A menu option that shows a history of all the items purchased. (While the script runs)
# Grocery store items have a quantity. (They can be out of stock)
