# require 'rest-client'
# require 'json'

require 'pry'
class DrankFindaWrapper

  attr_reader :url, :drink_hash,:catagory_number

  def initialize(url)
    @url = url
  end

  def url_parser
    get_drink = RestClient.get(url)

    @drink_hash = JSON.parse(get_drink)
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
 
      if drink_hash["data"]["categories"][@catagory_number]["children"] == nil?
        puts "Aint no drank where you at! Sozzz."
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
  