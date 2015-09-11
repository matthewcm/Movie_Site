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
    @movie.omdb_id = params[:id].to_s
    @movie_service = MovieService.new
    #Default parameters :) Finally got to use them.

    @movie = @movie_service.single_movie(params[:id].to_s, true)
  end
  def new
    @movie = Movie.new
  end

end

