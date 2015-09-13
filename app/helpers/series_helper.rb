module SeriesHelper
  def series_search(series, sort_key = 'Year' , how_many = 1)
    searcher = series_service.single_series(series, how_many)
    if how_many == 1
        if exists?(searcher) == true
              searcher = searcher
        else
          false
        end
    else
          if exists?(searcher) == true
              searcher = searcher["Search"].uniq{|m| m["imdbID"]}
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
    series = single_search(series)
    puts "============="
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