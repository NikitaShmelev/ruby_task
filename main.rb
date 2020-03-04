# frozen_string_literal: true

require 'csv'
require 'nokogiri'
require 'curb'

print("Insert link:\t")
url = gets.chomp
print("Print file name(without extension):\t")
csv_name = gets.chomp

puts('Searching for pages...')

links_on_pages = []
doc = Nokogiri::HTML(Curl.get(url).body_str)
links = doc.search('div.pro_outer_box a.product-name').map { |link| link['href'] }
links_on_pages.push(links)
i = 2

until links.empty?

  if url.include?('/?p=') && url[-1] != '/'
    url = url[0, url.length - 1] + (url[-1].to_i + (2 - 1)).to_s
  elsif !url.include?('/?p=') && url[-1] == '/' 
    url = url + '/?p=' + i.to_s
  else
    break 
  end

  doc = Nokogiri::HTML(Curl.get(url).body_str)
  links = doc.search('div.pro_outer_box a.product-name').map { |link| link['href'] }
  links_on_pages.push(links)
  i += 1
end

puts "Page count: #{links_on_pages.length - 1}"

CSV.open("#{csv_name}.csv", 'wb') do |csv|
  puts 'CSV file has been created'

  csv << %w[Name Price Image]

  links_on_pages.each_with_index do |links, item_index|
    
    puts "Searching on page №#{item_index + 1}"

    links.each do |link|
      doc = Nokogiri::HTML(Curl.get(link).body_str)
      
      name = doc.search('h1.product_main_name').xpath('text()')
      prices = doc.search('span.price_comb').map { |item| item.xpath('text()') }
      image = doc.search('img#bigpic').map { |item| item['src'] }
      
      doc.search('span.radio_label').map { |item| item.xpath('text()') }.each_with_index do |item, price_item|
        csv << ["#{name} #{item}", prices[price_item], image[0]]
      end
    end

    puts "Page №#{item_index + 1} finished"
  end
end

puts 'Work completed successfully'
