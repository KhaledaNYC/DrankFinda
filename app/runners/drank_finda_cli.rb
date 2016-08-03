require 'pry'
class DrankFindaCLI

  def call
    puts "Welcome, what DrankFinda!!"
    run
  end
    
  def get_user_input
    gets.chomp.strip.downcase
  end

  def run

    puts "Choose an option from the menu: search, help, or exit"
    input = get_user_input
      if input == "help"
       help
      elsif input == "exit"
        exit
      elsif input == "search"
        puts "What's yo street number?"
        address = gets.chomp
        address = address.split(" ").join("+")
        puts "What's yo zip code?"
        zip = gets.chomp
        puts "What do you want to drink? Wine, beer, or liquor?"
        alcohol = get_user_input
          if alcohol == "beer" || alcohol == "wine" || alcohol == "liquor"
            
            drink = DrankFindaWrapper.new(url(alcohol, nil, address, zip))
              drink.get_drinks(alcohol)
              puts "Which one would you like?"
              style_input = gets.chomp
              drink = DrankFindaWrapper.new(url(alcohol, style_input, address, zip))
              drink.search_drink_type 
          else
           puts "That's not a valid drink!"
          end
      else
        puts "That's not a valid menu entry!"
      end
    run unless input == "exit"
  end

  def search(alcohol) 
    puts "Your search term was #{search_term}, I am searching..."
    beer_json = DrankFindaWrapper.new(url(alcohol)).url_parser
    puts "Thank you for your patience. I found this on Twitter:"
    puts tweet.example
  end

  def help
    puts "Type 'exit' to exit"
    puts "Type 'help' to view this menu again"
    puts "Type anything else to search for a Tweet"
  end

  def exit
    puts "Byeeeeee!" 
  end

  def url(alcohol_type, style =nil, address=nil, zip=nil)

    url = "https://www.delivery.com/api/data/search?search_type=alcohol&?section=#{alcohol_type}&subsection=#{style}&address=#{address},#{zip}&order_time=ASAP&order_type=delivery&client_id=brewhacks2016"

  end

end

