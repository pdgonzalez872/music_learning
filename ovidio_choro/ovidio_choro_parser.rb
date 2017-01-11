require 'nokogiri'
require 'capybara'
require 'capybara'
require 'capybara/dsl'
require_relative 'data_parser'

# Config
Capybara.register_driver :selenium_chrome do |app|
  Capybara::Selenium::Driver.new(app, :browser => :chrome)
end
Capybara.javascript_driver = :chrome
Capybara.current_driver = :selenium_chrome

module YouTube
  class AudioJack
    include Capybara::DSL

    def download_url(video_url:, artist_name:, title:)
      begin
        puts "Starting for #{title}"

        start = Time.now
        sleep_default = 3
        sleep_long = 9
        sleep_whoa = sleep_long * 2

        puts "Visiting page"
        visit('http://www.audiojack.io/')

        puts "Fill in url"
        fill_in('url', with: video_url)
        sleep(sleep_default)

        puts "Click go"
        click_button("Go!")
        sleep(sleep_whoa)

        puts "Fill in artist"
        find('#custom-artist')
        fill_in('custom-artist', with: artist_name)
        sleep(sleep_default)

        puts "Fill in title"
        find('#custom-title')
        fill_in('custom-title', with: title)
        sleep(sleep_default)

        # scroll to make the button visible
        puts "Scroll down"
        page.execute_script "window.scrollBy(0,10000)"
        click_button("Download with custom tags")
        sleep(sleep_whoa)

        puts "Starting dowload"
        find(".dl").click
        sleep(sleep_long)

        puts "Finished with #{title}"
        puts "Took #{Time.now - start} seconds"

      rescue Capybara::ElementNotFound
        puts "ERROR -> WHOOOOOOOOOOOOO"
        download_url(video_url: video_url, artist_name: "Ovidio", title: title)
      end
    end
  end
end

b = YouTube::AudioJack.new

filepath = 'ovidio_choro/urls.txt'

counter = 0

while File.zero?(filepath) == false
  puts "At iteration #{counter + 1}"
  text = ''
  puts "Opening file"
  File.open(filepath, "r") do |f|
    first_line = f.gets
    puts "#{first_line}"

    video = line_parser(line: first_line)
    b.download_url(video_url: "#{video['url']}", artist_name: "Ovidio", title: "#{video['title']}")

    text = f.read
  end

  puts "Updating file"
  File.open(filepath, "w") {|f| f.write(text)}

  counter += 1
end
