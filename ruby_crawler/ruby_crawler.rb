

require 'proxycrawl'
require 'nokogiri'

api = ProxyCrawl::API.new(token: 'rd70Jd34dPtdY2IRGYjwOg')

url = 'https://www.amazon.com/s?bbn=16225007011&rh=i%3Aspecialty-aps%2Cn%3A16225007011%2Cn%3A1292115011&ref_=nav_em__nav_desktop_sa_intl_monitors_0_2_6_8'
html = api.get(url)

doc = Nokogiri::HTML.parse(html.body)

products = []
product_name = []
prices = []

doc.css('.a-section.a-spacing-small.puis-padding-left-small.puis-padding-right-small').map do |a|
  products.push(a)
end

products.each do |product|
  product.css('.a-size-base-plus.a-color-base.a-text-normal').map do |a|
    product_name.push(a.text.strip)
    puts a.text.strip
  end
  product.css('[class="a-price"]').css('.a-offscreen').map do |a|
    prices.push(a.text.strip)
    puts a.text.strip

  end
end
# doc.css('.a-size-base-plus.a-color-base.a-text-normal').map do |a|
#   product_name.push(a.text.strip)
# end



# a-section a-spacing-small puis-padding-left-small puis-padding-right-small
# a-size-base-plus a-color-base a-text-normal

puts "Amazon Category URL: #{url}"
puts "Amazon Product Name: #{product_name}"
puts "Amazon Product Price: #{prices}"
puts "Amazon Product Name Len: #{product_name.length}"

puts "Amazon Product Price Len: #{prices.length}"
#puts "Amazon Product Price: #{doc}"