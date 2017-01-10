require 'nokogiri'

puts "start"

file = File.open("ovidio_choro/video_page.html") do |f|
  Nokogiri::HTML(f)
end

file.css("li .channels-content-item").each do |i|
 puts i.children[1].elements[0].css("a")[1]["href"]
end
puts "finish"
