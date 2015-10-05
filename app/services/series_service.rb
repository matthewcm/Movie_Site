class SeriesService

    def single_series(series , how_many = 1)
        series.strip!
        url = URI.parse('http://www.omdbapi.com/')
        if how_many == 1
            searcher = "?i=#{series}&apikey=40584c09"
        else
            series = series.to_s.gsub(' ',"+")
            searcher = "?s=#{series}&apikey=40584c09&type=series"
        end
        puts searcher
        req = Net::HTTP::Get.new("#{url.to_s}#{searcher}&plot=full")
        res = Net::HTTP.start(url.host, url.port){|http|
            http.request(req)}
        series_list = JSON.parse(res.body)
        puts series_list
        series_list
    end
    def single_episode(series , season = '1',  episode ='1')
        series.strip!
        url = URI.parse('http://www.omdbapi.com/')
        series = series.gsub(' ', '+')
        searcher = "?t=#{series}&Season=#{season}&Episode=#{episode}"
        req = Net::HTTP::Get.new("#{url.to_s}#{searcher}&apikey=40584c09")
        res = Net::HTTP.start(url.host, url.port){|http|
            http.request(req)}
        series_body = JSON.parse(res.body)
    end
end
