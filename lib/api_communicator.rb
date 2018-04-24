require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)
  #make the web request
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)

  # iterate over the character hash to find the collection of film urls for the given
  # character
  film_urls = []
  character_hash.fetch("results").each do |result|
   # binding.pry
    if result["name"].downcase == character
      # collect film API urls
      film_urls = result["films"]
    end
  end

  #check if film url is empty!!

  #web request each URL to get the info for that film and store it in
  #the film collection array
  films_hash = []
  film_urls.each do |film|
    film_request = RestClient.get(film)
    film_hash = JSON.parse(film_request)
    films_hash.push(film_hash)
  end

  #returns array of hashes containing character's films
  #binding.pry
  films_hash
end

def parse_character_movies(films_hash, character)
  #check if films_hash is empty, return message
  if films_hash ==[]
    puts "No movies found for character"
  else
  #returns movie info
    puts "\n\n#{character} appears in the following films:\n\n"
    films_hash.each do |film_hash|
      puts "Title: #{film_hash.fetch('title')}"
      puts "Episode: #{film_hash.fetch('episode_id')}"
      puts "Release: #{film_hash.fetch('release_date')}"
      puts "Director: #{film_hash.fetch('director')}"
      puts "********"
    end
  end
end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash, character)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?

#get_character_movies_from_api("Luke Skywalker")
