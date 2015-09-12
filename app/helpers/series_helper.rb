module SeriesHelper
  def search(series)
    searcher = series_service.search_series(series)

    if exists?(searcher) == true
         searcher = searcher["Search"]
          searcher = searcher.uniq{|m| m["imdbID"]}
          searcher = searcher.sort_by{|n| n["Year"]}
          searcher.select{|series|  is_good_series?(series)}
    else
      false
    end

    end
  def single_search(series)
    @series = series_service.single_series(series)
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

  def exists? (series)
    if (series.size == 1 )
      true
    else
      false
    end
  end
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
  def searcher_params
    params.require(:searcher).permit(:search_input)
  end
end