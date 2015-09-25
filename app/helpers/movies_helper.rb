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
          searcher = searcher.select{|movie|  is_good_movie?(movie)}
    else
      searcher = false
    end
    searcher
  end
  def single_search(movie , idOn = false)
    @movie = movie_service.single_movie(movie, idOn)
 end
def single_poster(movie)
          poster = movie['Poster']
          id = movie['imdbID']
          url = URI.parse(poster)

          if poster != 'N/A'
            if movie_service.url_pass("#{url.to_s}")
              poster = "#{url.to_s}"
            else
              url = URI.parse('http://img.omdbapi.com/')
             searcher = "?i=#{id}"
              if movie_service.url_pass("#{url.to_s}#{searcher}&apikey=40584c09")
                poster = "#{url.to_s}#{searcher}&apikey=40584c09"
              else
                poster = 'noposter.jpg'
              end
            end
          else
                poster = 'noposter.jpg'
          end
        poster
end
  # def single_poster(movie_poster)
  #         puts movie_poster
  #         puts 'apricot'
  #        url = URI.parse(movie_poster)

  #        http = Net::HTTP.new(url.host, url.port)
  #        request = Net::HTTP::Get.new(url.request_uri)
  #        response = http.request(request)
  #        if movie_poster != 'N/A'
  #        poster = "#{url.to_s}"
  #       else
  #         poster = 'noposter.jpg'
  #       end
  #       poster
  # end
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
    puts movie["Title"]
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
