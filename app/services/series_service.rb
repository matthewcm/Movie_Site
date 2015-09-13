class SeriesService

    def single_series(series , how_many = 1)
        url = URI.parse('http://www.omdbapi.com/')
        series = series.gsub(' ', '+')
        if how_many == 1
            searcher = "?t=#{series}&apikey=40584c09"
        else
            searcher = "?s=#{series}&apikey=40584c09&type=series"
        end
        puts "#{url.to_s}#{searcher}"
        req = Net::HTTP::Get.new("#{url.to_s}#{searcher}")
        res = Net::HTTP.start(url.host, url.port){|http|
            http.request(req)}
        series_list = JSON.parse(res.body)
    end
    def single_episode(series , season = '1',  episode ='1')
        url = URI.parse('http://www.omdbapi.com/')
        series = series.gsub(' ', '+')
        searcher = "?t=#{series}&Season=#{season}&Episode=#{episode}"
        puts "#{url.to_s}#{searcher}&apikey=40584c09"
        req = Net::HTTP::Get.new("#{url.to_s}#{searcher}&apikey=40584c09")
        res = Net::HTTP.start(url.host, url.port){|http|
            http.request(req)}
        series_body = JSON.parse(res.body)
    end
    def url_pass(link)
        url = URI.parse("#{link}")
        uri = URI(url)
        request = Net::HTTP.new uri.host
        response= request.request_head uri.path
        Net::HTTP.start(url.host, url.port) do |http|
            return http.head(url.request_uri)['Content-Type'].start_with? 'image'
        end
    end

end
