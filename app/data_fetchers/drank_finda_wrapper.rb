# require 'rest-client'
# require 'json'

require 'pry'
class DrankFindaWrapper

  attr_reader :url, :drink_hash,:catagory_number

  def initialize(url)
    @url = url
  end

  def url_parser
    
    get_drink = RestClient.get(url){ |response, request, result, &block|
  case response.code
  when 200
    response
  when 404
    begin 
      raise FourohFourError
    rescue FourohFourError => error
      puts error.message
    end
  else
    response.return!(request, result, &block)
  end
}

  if get_drink == nil
    @drink_hash = nil
  else
    @drink_hash = JSON.parse(get_drink)
  end
end

  def get_drinks(alcohol_type)
    url_parser
    @catagory_number = nil
    if alcohol_type == "wine"
      @catagory_number = 0
    elsif alcohol_type == "liquor"
      @catagory_number = 1
    elsif alcohol_type == "beer"
      @catagory_number = 2
    else
      "enter a valid drink"
    end
#binding.pry
      if drink_hash == nil
        puts "No delivery in your area! Sozz"
        return "no drinks"
      elsif
        drink_hash["data"]["categories"][@catagory_number] == nil
        puts "Aint no #{alcohol_type} where you at! Sozzz."
        return "no drinks"
      else
      drink_hash["data"]["categories"][@catagory_number]["children"].each do |item|
        puts item["value"]
      end
    end
  end

  def search_drink_type
    url_parser
      drink_hash["data"]["merchants"].each_with_index do |merchant, i|
        puts "Name: #{merchant["summary"]["name"]}"
        puts "Phone: #{merchant["summary"]["phone"]}"
        puts "About: #{merchant["summary"]["description"]}"
        puts "***********************************************"
      end   
  end
end

class FourohFourError < StandardError
  def message
   "Aint no delivery dranks in yo area! Sozzzz."
 end
end
  