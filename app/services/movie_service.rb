
class MovieService

    def search_movies(movies)
        url = URI.parse('http://www.omdbapi.com/')
        movies = movies.to_s.gsub(' ', '+')
        searcher = "?s=#{movies}&apikey=40584c09&type=movie"
        req = Net::HTTP::Get.new("#{url.to_s}#{searcher}")
        res = Net::HTTP.start(url.host, url.port){|http|
            http.request(req)}
        movie_list = JSON.parse(res.body)
    end


    def single_movie(movie, idOn = false)
        url = URI.parse('http://www.omdbapi.com/')
        if idOn
            searcher = "?i=#{movie}"
        else
            searcher = "?i=#{movie['imdbID']}"
        end
        #puts "#{url.to_s}#{searcher}"
        req = Net::HTTP::Get.new("#{url.to_s}#{searcher}&apikey=40584c09&plot=full")
        res = Net::HTTP.start(url.host, url.port){|http|
            http.request(req)}
        movie_body = JSON.parse(res.body)
    end
    def omdb_poster(movie)
        url = URI.parse('http://img.omdbapi.com/')
        searcher = "?i=#{movie['imdbID']}"
        puts "#{url.to_s}#{searcher}"
        poster_url ="#{url.to_s}#{searcher}&apikey=40584c09&plot=full"
        if url_pass('http://ia.media-imdb.com/images/M/MV5BMTE0Mjc1MTk2MjFeQTJeQWpwZ15BbWU4MDk2NzI4MDYx') == true
            poster_url
        else
            "N/A"
        end
    end
    def url_pass(link)
        uri = URI(link)
        res = Net::HTTP.get_response(uri)
        puts res.code
        if res.code == '404'
            result = false
        else
            result = true
        end
        result
    end
end
