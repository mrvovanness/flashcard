# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'nokogiri'
require 'open-uri'
doc = Nokogiri::HTML(open("http://www.spanishdict.com/blog/6/top-100-spanish-words-people-really-want-to-know"))

doc.xpath('//tr')[1..100].each do |x|
  Card.create(original_text: x.css('td')[0].text.sub(/\d{1,}\./, '').strip, translated_text: x.css('td')[1].text.sub(/\d{1,}\./, '').strip)
end
