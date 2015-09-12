class SeriesService

    def search_series(series)
        url = URI.parse('http://www.omdbapi.com/')
        series = series.gsub(' ', '+')
        searcher = "?t=#{series}&apikey=40584c09&type=series"
        req = Net::HTTP::Get.new("#{url.to_s}#{searcher}")
        res = Net::HTTP.start(url.host, url.port){|http|
            http.request(req)}
        series_list = JSON.parse(res.body)
    end
    def single_episode(series , season,  episode)
        url = URI.parse('http://www.omdbapi.com/')
        searcher = "?t=#{series}&season#{season}&episode#{episode}"
        req = Net::HTTP::Get.new("#{url.to_s}#{searcher}&apikey=40584c09&type=episode")
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
