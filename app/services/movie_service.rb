
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
    def url_pass(link)
        uri = URI(link)
        res = Net::HTTP.get_response(uri)
        puts res.code
        if res.code == 403
            return false
        else
            request = Net::HTTP.new uri.host
            response= request.request_head uri.path
            Net::HTTP.start(uri.host, uri.port) do |http|
                return http.head(uri.request_uri)['Content-Type'].start_with? 'image'
            end
        end
    end
end
