module SeriesHelper
  def series_search(series, sort_key = 'imdbID' , how_many = 1)
    series = series.to_s.gsub('"', ' ').gsub('<', ' ').gsub('>', ' ').gsub(';', ' ').gsub('/', ' ')
    puts series
    puts 'test test '
    searcher = series_service.single_series(series, how_many)
    puts "jajajaja"
    puts searcher
    if how_many == 1
        if exists?(searcher.size) == true
            puts searcher
            puts '1'
              searcher = searcher
        else
          false
        end
    else
          if exists?(searcher.size) == true
              searcher = searcher["Search"]
              puts '>1'
              puts searcher
              searcher = searcher.uniq{|m| m["imdbID"]}
              searcher = searcher.sort_by{|n| n["#{sort_key}"]}
        else
          false
        end
    end


    end

  def episode_search(series)
    @series = series_service.single_episode(series)
 end
  def single_poster(series_id)
         url = URI.parse('http://img.omdbapi.com/')
         searcher = "?i=#{series_id}"
         if series_service.url_pass("#{url.to_s}#{searcher}&apikey=40584c09")
         poster = "#{url.to_s}#{searcher}&apikey=40584c09"
        else
          poster = 'noposter.jpg'
        end
        poster

  end
  private

  def is_good_series?(series)
    series = series_service.single_series(series)
    puts "============="
    puts series
    puts series["Title"]
    puts series["Type"]
    puts series["imdbRating"]
    puts series["Plot"]
    puts "============="
    ((series["imdbRating"].to_i > 1) &&  (series["Plot"] != 'N/A'))
  end

  private
  def series_service
    SeriesService.new
  end
  # def searcher_params
  #   params.require(:searcher).permit(:search_input)
  # end
end