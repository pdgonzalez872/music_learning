# youtube-dl --extract-audio --audio-format mp3 https://www.youtube.com/watch?v=aLnSO6FQpHs &&
#
puts "start"

my_pwd = "/Users/paulogonzalez1/Desktop/dev/youtube_video_downloads"

file_names = File.read("urls.txt").split("\n")

file_names.each do |f|
  system("youtube-dl --extract-audio --audio-format mp3 #{f}")
end

puts "end"
