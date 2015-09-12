module MoviesHelper
  def search(movies)
    search = movie_service.search_movies(movies)
    search = search["Search"]
    search = search.uniq{|m| m["imdbID"]}
    search = search.sort_by{|n| n["Year"]}
    search.select{|movie|  is_good_movie?(movie)}
    end
  def single_search(movie)
    @movie = movie_service.single_movie(movie)
 end
  def single_poster(movie_id)
         url = URI.parse('http://img.omdbapi.com/')
         searcher = "?i=#{movie_id}"
         if movie_service.url_pass("#{url.to_s}#{searcher}&apikey=40584c09")
         poster = "#{url.to_s}#{searcher}&apikey=40584c09"
        else
          poster = 'noposter.jpg'
        end
        poster

  end
  private
  def is_good_movie?(movie)
    movie = single_search(movie)
    puts "============="
    puts movie["Title"]
    puts movie["Type"]
    puts movie["imdbRating"]
    puts "============="
    ((movie["imdbRating"].to_i > 5 )&& (movie["Type"] == "movie"))
  end

  private
  def movie_service
    MovieService.new
  end
  def searcher_params
    params.require(:searcher).permit(:search_input)
  end
end
