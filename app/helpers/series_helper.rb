module SeriesHelper
  def series_search(series, sort_key = 'imdbID' , how_many = 1)
    series = series.to_s.gsub('"', ' ').gsub('<', ' ').gsub('>', ' ').gsub(';', ' ').gsub('/', ' ')
    searcher = series_service.single_series(series, how_many)
    if how_many == 1
        if exists?(searcher) == true
              searcher = searcher
        else
          false
        end
    else
          if exists?(searcher) == true
              searcher = searcher["Search"]
              searcher = searcher.uniq{|m| m["imdbID"]}
              searcher = searcher.sort_by{|n| n["#{sort_key}"]}
        else
          false
        end
    end
    end
  def episode_search(series)
    @series = series_service.single_episode(series, 1)
 end
 def series_episodes_search(series, season=1)
      puts 'Juji'
      puts series
      @episodes = series_service.series_episodes(series, season)

  end


  private

  def is_good_series?(series)
    series = series_service.single_series(series)
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