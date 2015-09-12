class SeriesController < ApplicationController
    def index
        @series_service= SeriesService.new
    end
    def search
        @series_name = params[:q]
    end
    def show
        @review = Review.new
        @season_episode = singleEpisode
    end
    private
    def singleEpisode
        @series_service = MovieService.new
    end
end
