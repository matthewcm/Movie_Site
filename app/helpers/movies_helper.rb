module MoviesHelper
  def search(movies)
    searcher = movie_service.search_movies(movies)
    puts searcher
    puts '=.='
    if exists?(searcher) == true
         searcher = searcher["Search"]
          searcher = searcher.uniq{|m| m["imdbID"]}
          searcher = searcher.sort_by{|n| n["Year"]}
          searcher = searcher.select{|movie|  is_good_movie?(movie)}
    else
      searcher = false
    end
    searcher
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

  def exists? (movie)
    if movie.size == 1
      true
    else
      false
    end
  end
  def is_good_movie?(movie)
    movie = single_search(movie)
    puts "============="
    puts movie["Title"]
    puts movie["Type"]
    puts movie["imdbRating"]
    puts movie["Plot"]
    puts "============="
    ((movie["imdbRating"].to_i > 1) &&  (movie["Plot"] != 'N/A'))
  end

  private
  def movie_service
    MovieService.new
  end
  def searcher_params
    params.require(:searcher).permit(:search_input)
  end
end
