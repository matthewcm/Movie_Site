require "net/http"
require "uri"

module MoviesHelper
  def search(movies , sort_key = 'imdbID')
    movies = movies.to_s.gsub('"', ' ').gsub('<', ' ').gsub('>', ' ').gsub(';', ' ').gsub('/', ' ')
    searcher = movie_service.search_movies(movies.to_s)
    if exists?(searcher.size) == true
         searcher = searcher["Search"]
          searcher = searcher.uniq{|m| m["imdbID"]}
          searcher = searcher.sort_by{|n| n["#{sort_key}"]}
          # searcher = searcher.select{|movie|  is_good_movie?(movie)}
    else
      searcher = false
    end
    searcher
  end
  def single_search(movie , idOn = false)
    @movie = movie_service.single_movie(movie, idOn)
 end
   def single_poster(poster, no_check=false, mac = false)
      if mac == true
        poster = poster["Poster"]
          if poster != 'N/A'
           poster = "#{poster.to_s}"
          else
            poster = 'noposter.jpg'
          end
          poster
      else
          poster = movie_service.omdb_poster(poster, no_check)
           if poster != 'N/A'
           poster = "#{poster.to_s}"
          else
            poster = 'noposter.jpg'
          end
          poster
        end
  end
  private

  def exists? (movie)
    if movie == 2
      false
    else
      true
    end
  end
  def is_good_movie?(movie)
    movie = single_search(movie)
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
