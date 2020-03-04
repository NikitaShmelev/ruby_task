require 'csv'
require 'nokogiri'
require 'curb'
require 'open-uri'
require "css_parser"
# puts('print link')
# url = gets.chomp
# puts('print file name')
# csv_name = gets.chomp

http = Curl.get("https://www.petsonic.com/pienso-veterinario-royal-canin-veterinary-diets-productos-veterinarios-para-perros/?p=2")
doc = Nokogiri::HTML(http.body_str)

button = doc.search("div.af button[@class='loadMore next button lnk_view btn btn-default']")
css = CssParser::Parser.new
puts http.body_str.class


css.add_block!(http.body_str)
puts button.to_s.class
# links = doc.search('div.pro_outer_box a.product-name').map { |link| link['href'] }

# links.each do |link|
#   http = Curl.get(link)
#   doc = Nokogiri::HTML(http.body_str)
#   # doc = Nokogiri::HTML(open(link))

#   labels = doc.search('label.attribute_label').map { |item| item.xpath('text()') }

#   name = doc.search('h1.product_main_name').xpath('text()')
#   prices = doc.search('li.no_disponible span.price_comb').map { |item| item.xpath('text()') }
#   image = doc.search('img#bigpic').map { |item| item['src'] }
#   doc.search('span.radio_label').map { |item| item.xpath('text()') }.each_with_index do |item, index|
#     puts "#{name} #{item} #{prices[index]} #{image[0]}"
#   end
# end



html_string = http.body_str
html = Nokogiri::HTML(html_string)
css = CssParser::Parser.new
css.add_block!(html_string) # Warning:  This line modifies the string passed into it.  In potentially bad ways.  Make sure the string has been duped and stored elsewhere before passing this.

css.each_selector do |selector, declarations, specificity|
  next unless selector =~ /^[\d\w\s\#\.\-]*$/ # Some of the selectors given by css_parser aren't actually selectors.
  begin
    elements = html.css(selector)
    elements.each do |match|
      match["style"] = [match["style"], declarations].compact.join(" ")
    end
  rescue
    
  end
end

html_with_inline_styles = html.to_s
puts html_with_inline_styles