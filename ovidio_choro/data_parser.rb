require 'nokogiri'
require 'pry'
require 'csv'

puts "Gather data"
file = File.open("ovidio_choro/video_page.html") do |f|
  Nokogiri::HTML(f)
end

videos = []

file.css("li .channels-content-item").each do |i|
  video = {}
  video['title'] = i.children[1].elements[0].css("a")[1]["title"]
  video['url']   = i.children[1].elements[0].css("a")[1]["href"]
  videos << video
end

# This was to write the original file
# output = File.open('ovidio_choro/urls.txt', 'w+')
# videos.each do |video|
#   output.puts "#{video['title']}|#{video['url']}"
# end

# takes a file and returns an array of hashes
def file_parser_csv(file:)
  # delete this
  videos = []
  CSV.foreach(file) do |row|
    video = {}
    split_row = row[0].split("|")

    video['title'], video['url'] = split_row[0], split_row[1]
    videos << video
  end
  videos
end

def file_parser(file:)
  videos = []
  File.open(file).each_line do |line|
    video = {}
    split_line = line.split('|')
    video['title'], video['url'] = split_line[0], split_line[1]
    videos << video
  end
  videos
end

puts file_parser(file: 'ovidio_choro/urls.txt')
