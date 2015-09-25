class SeriesService

    def single_series(series , how_many = 1)
        url = URI.parse('http://www.omdbapi.com/')
        if how_many == 1
            searcher = "?i=#{series}&apikey=40584c09"
        else
            series = series.to_s.gsub(' ',"+")
            searcher = "?s=#{series}&apikey=40584c09&type=series"
        end
        req = Net::HTTP::Get.new("#{url.to_s}#{searcher}&plot=full")
        res = Net::HTTP.start(url.host, url.port){|http|
            http.request(req)}
        series_list = JSON.parse(res.body)
    end
    def single_episode(series , season = '1',  episode ='1')
        url = URI.parse('http://www.omdbapi.com/')
        series = series.gsub(' ', '+')
        searcher = "?t=#{series}&Season=#{season}&Episode=#{episode}"
        req = Net::HTTP::Get.new("#{url.to_s}#{searcher}&apikey=40584c09")
        res = Net::HTTP.start(url.host, url.port){|http|
            http.request(req)}
        series_body = JSON.parse(res.body)
    end
    def url_pass(link)
        uri = URI(link)
        res = Net::HTTP.get_response(uri)
             puts res.code
            puts 'RES CODE ^^^^^^'
            res.code
        request = Net::HTTP.new uri.host
        response= request.request_head uri.path
        Net::HTTP.start(uri.host, uri.port) do |http|
            return http.head(uri.request_uri)['Content-Type'].start_with? 'image'
        end

    end

end
