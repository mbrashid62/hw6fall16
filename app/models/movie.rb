class Movie < ActiveRecord::Base
  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end
  
class Movie::InvalidKeyError < StandardError ; end

 def self.find_in_tmdb(string)
   begin
     @search = Tmdb::Search.new # creates
     @search.resource('movie') # determines type of resource - this case Movie
     @search.query(string) # the query to search against
     @matching_movies = @search.fetch # makes request
     matching_movies_array = Array.new
     if string == '' # if no results found
       return []
     else
       @matching_movies.each do |movie|
         releases = Tmdb::Movie.releases(movie['id']) # fetch releases objects from tmdb
         country_releases = releases['countries'] # select primary release hash from array of hashes
         us_release = country_releases.select {|release| release['iso_3166_1'] == 'US'}
         if us_release != nil && us_release.length != 0  && us_release[0]['certification'] != '' # check if the film was released in the US
           rating = us_release[0]['certification'] # assign rating to local var
         else
           rating = 'N/A'
         end

         release_date = movie['release_date'] # fetch release date
         if release_date == ''
           release_date = 'TBD'
         end
         
         movie_hash = {
             :tmdb_id => movie['id'],
             :rating => rating,
             :title => movie['title'],
             :release_date => release_date,
             :overview => movie['overview']
         }
         matching_movies_array.push(movie_hash)

       end
     end
     matching_movies_array

   rescue Tmdb::InvalidApiKeyError
       raise Movie::InvalidKeyError, 'Invalid API key'
   end
 end
end
