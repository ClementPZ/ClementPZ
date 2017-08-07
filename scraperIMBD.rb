require 'open-uri' # Open an url
require 'nokogiri' # HTML ==> Nokogiri Document

url = "http://www.imdb.com/chart/top"
base_url = "http://www.imdb.com"

html_file = open(url)
html_doc = Nokogiri::HTML(html_file)

movies_doc = html_doc.search('.titleColumn a')

movies_doc.each do |element|
  # sleep(1)
  title = element.text
  link = element.attribute('href')
  actors = element.attribute('title')

  # Sub url for each movie
  sub_url = "#{base_url}#{link}"

  # Open sub url to retrieve movie summary
  html_file = open(sub_url)
  html_doc = Nokogiri::HTML(html_file)
  summary = html_doc.search('.summary_text').text.strip

  # Creates movie text content with line return
  movie_text = "#{title}\n"
  movie_text += "#{actors}\n"
  movie_text += "#{summary}\n"

  # Creates a .txt file for each movie
  file_path = "#{title.gsub(' ', '')}.txt"
  File.open(file_path, 'w') do |file|
    file.write(movie_text)
  end
end



