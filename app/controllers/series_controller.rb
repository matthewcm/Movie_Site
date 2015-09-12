class SeriesController < ApplicationController
    def index
        @movie_service = MovieService.new
    end
    def search
        @movie_name = params[:q]
    end
    def show
        @review = Review.new
        @movie = singleMovie
    end
    private
    def singleMovie
        @movie_service = MovieService.new
        @movie_service.single_movie(params[:id].to_s, true)
    end
end
