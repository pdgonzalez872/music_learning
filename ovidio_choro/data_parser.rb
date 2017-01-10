require 'nokogiri'
require 'pry'
require 'csv'

# return Array
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
