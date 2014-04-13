require 'httparty'
require 'pry'
require 'json'
require 'open-uri'
require 'date'

api_key = ENV['RT_API_KEY']
#opening_movies = JSON.parse(HTTParty.get("http://api.rottentomatoes.com/api/public/v1.0/lists/movies/opening.json?limit=50&country=us&apikey=#{api_key}"))["movies"] 
#box_office_movies= JSON.parse(HTTParty.get("http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?limit=16&country=us&apikey=#{api_key}"))["movies"] 
in_theatre_movies = JSON.parse(HTTParty.get("http://api.rottentomatoes.com/api/public/v1.0/lists/movies/in_theaters.json?page_limit=50&page=1&country=us&apikey=#{api_key}"))["movies"] 

good_movies = []


def find_good_movies(movies)
    good_movies = []
    movies.each do |movie|
        if movie['ratings']['critics_score'] > 80
            keep = {}
            keep['title'] = movie['title']
            keep['release_date'] = movie['release_dates']['theater']
            keep['critics_score'] = movie['ratings']['critics_score']
            good_movies.push(keep)
        end
    end
    return good_movies
end



#good_movies.push(find_good_movies(opening_movies))
#good_movies.push(find_good_movies(box_office_movies))
good_movies.push(find_good_movies(in_theatre_movies))

def clean_up_movies(good_movies)
    good_movies = good_movies.flatten!
    good_movies = good_movies.uniq!
end

good_movies = clean_up_movies(good_movies)
binding.pry
#good_movies.each do |movie|
#    clean_up_dates(movie["release_date"])
#end



#def clean_up_dates(date)
#    date.gsub("-",",")
#end





# convert dashes in dates with commas
# convert date strings into dates
# sort movies by date


binding.pry
