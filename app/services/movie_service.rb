
class MovieService

    def search_movies(movies)
        url = URI.parse('http://www.omdbapi.com/')
        movies = movies.to_s.gsub(' ', '+')
        searcher = "?s=#{movies}&apikey=40584c09&type=movie"
        puts url+searcher
        req = Net::HTTP::Get.new("#{url.to_s}#{searcher}")
        res = Net::HTTP.start(url.host, url.port){|http|
            http.request(req)}
        movie_list = JSON.parse(res.body)
        puts movie_list
        movie_list
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
    def omdb_poster(movie, no_check)
        url = URI.parse('http://img.omdbapi.com/')
        searcher = "?i=#{movie['imdbID']}"
        poster_url ="#{url.to_s}#{searcher}&apikey=40584c09&plot=full"
        if no_check == true
            poster_url
        else
            if url_pass(poster_url) == true
                poster_url
            else
                "N/A"
            end
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
