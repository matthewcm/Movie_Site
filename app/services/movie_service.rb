
class MovieService

    def search_movies(movies)
        url = URI.parse('http://www.omdbapi.com/')
        movies = movies.sub(' ', '+')
        searcher = "?s=#{movies}&apikey=40584c09"

        puts '=============bananapeaches'
        #puts "#{url.to_s}#{searcher}"
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
        req = Net::HTTP::Get.new("#{url.to_s}#{searcher}&apikey=40584c09")
        res = Net::HTTP.start(url.host, url.port){|http|
            http.request(req)}
        movie_body = JSON.parse(res.body)
    end

end
