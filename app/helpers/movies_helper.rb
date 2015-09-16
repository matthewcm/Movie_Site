module MoviesHelper
  def search(movies , sort_key = 'Year')
    movies = movies.to_s.gsub('"', ' ')
    puts movies
    puts 'test test '

    searcher = movie_service.search_movies(movies.to_s)

    if exists?(searcher.size) == true
         searcher = searcher["Search"]
          searcher = searcher.uniq{|m| m["imdbID"]}
          searcher = searcher.sort_by{|n| n["#{sort_key}"]}
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
    if movie == 2
      puts 'is 2 jaffa'
      false
    else
      puts 'not 2 jaffa'
      true
    end
  end
  def is_good_movie?(movie)
    movie = single_search(movie)
    puts "============="
    puts movie["Title"]
    puts movie["Type"]
    puts movie["imdbRating"]
    puts "============="
    ((movie["imdbRating"].to_i > 4) &&  (movie["Rated"] != 'N/A'))
  end

  private
  def movie_service
    MovieService.new
  end
  def searcher_params
    params.require(:searcher).permit(:search_input)
  end
end
