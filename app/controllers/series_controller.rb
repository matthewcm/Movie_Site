class SeriesController < ApplicationController
  def index
    @review_service = SeriesService.new
  end
  def search
    @series_name = params[:q]
  end
  def show
    @review = Review.new
    @episodes = singleEpisode
    @series = searchSeries
  end
  def destroy
    review = Review.find(params[:id])
    review.destroy
    redirect_to movies_path
  end
  private
  def singleEpisode
        @series_service = SeriesService.new
        @series_service.single_episode(params[:id].to_s, 1)
  end
  def searchSeries
        @series_service = SeriesService.new
        @series_service.single_series(params[:id].to_s, 1)
  end
end


