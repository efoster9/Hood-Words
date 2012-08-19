require "rubygems"
require "haml"
require "json"
require "uri"
require "net/http"
require "sinatra"

get "/" do
  hood_words = []

  #load curated hood words list to choose from
  File.open("words.txt").each_line do |line|
    hood_words << line.strip.tr("\n","")
  end

  # choose a word to define
  @chosen_word = hood_words.sample

  # get definition
  # TODO: build my own parser for urbandictionary
  data = Net::HTTP.get_response(URI.parse("http://urbanscraper.herokuapp.com/define/#{URI.escape(@chosen_word)}.json")).body
  
  # parse response so it makes some kinda sense
  @definition = JSON::parse(data)["definition"]

  # render the output
  haml :root
end