# require 'csv'
require 'nokogiri'
# require 'curb'
require 'open-uri'



# puts('print link')
# url = gets.chomp
# puts('print file name')
# csv_name = gets.chomp
url = 'https://www.petsonic.com/snacks-higiene-dental-para-perros/'
doc = Nokogiri::HTML(open(url))
links = doc.search('div.pro_outer_box a.product-name').map { |link| link['href'] }
# puts(links)

# links.each do |link|

#     html = Nokogiri::HTML(open(link))

# sad.search('label.attribute_label').xpath('text()')










# end


doc = Nokogiri::HTML(open('https://www.petsonic.com/greenie-pack-original-petite-para-perro.html'))




labels = doc.search('label.attribute_label').map { |item| item.xpath('text()').to_s }.map { |item| item[0, item.length - 1]}

name = doc.search('h1.product_main_name').xpath('text()')
prices = doc.search('li.no_disponible span.price_comb').map { |item| item.xpath('text()').to_s }
image = doc.search('img#bigpic').map { |item| item['src'] }
puts image
if labels.include?('Peso')
  doc.search('span.radio_label').map { |item| item.xpath('text()').to_s }.each_with_index do |item, index|
    puts "#{name} #{item} #{prices[index]} #{image[0]}"
  end
end



# labels.each do |i|
#   puts i.to_s[0, i.to_s.length-1]
# end
# puts doc.search('li.no_disponible span.radio_label').map { |link| link.xpath('text()') }[0].class
# if labels.map{ |item| item.to_s[0, item.to_s.length-1] }.include?('Peso')
#   if doc.search('span.radio_label').xpath('text()')
# end
# puts labels.map{ |item| item.to_s }
# puts labels[0].to_s[0, labels[0].to_s.length-1]
# a.map{ |item| item.to_s }.each do |i|
#     puts i[0,i.length-1], i[0,i.length-1]=='Peso'
# end

# puts a.map{ |item| item.to_s[0, 4] }