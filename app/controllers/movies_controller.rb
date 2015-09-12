require 'net/http'
require 'json'
require 'uri'
class MoviesController < ApplicationController
    #caches_page :index

  def index
    @movie_service = MovieService.new
   # fresh_when @movies
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

