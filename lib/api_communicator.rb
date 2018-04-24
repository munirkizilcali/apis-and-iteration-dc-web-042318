require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)
  #make the web request
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)
  films = []
  character_hash["results"].each do |char|
    if char["name"].downcase == character
      films = char["films"]
    end
  end
  # iterate over the character hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `parse_character_movies`
  #  and that method will do some nice presentation stuff: puts out a list
  #  of movies by title. play around with puts out other info about a given film.
  if films == []
    puts "No character available by that name in any film."
  end
  films
end

def parse_character_movies(films_hash)
  # some iteration magic and puts out the movies in a nice list
  movies = []
  movie_hash = {}
  films_hash.each do |url|
    movie_hash = JSON.parse(RestClient.get(url))
    puts "Movie: #{movie_hash['title']}"
    puts "Episode: #{movie_hash['episode_id']}"
    puts "Year: #{movie_hash['release_date']}"
    puts "Director: #{movie_hash['director']}"
    puts "***************************"
  end
end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?

