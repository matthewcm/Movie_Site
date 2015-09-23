require 'net/http'
require 'json'
require 'uri'
require 'enumerator'
require_dependency 'validators/email_validator.rb'
class MoviesController < ApplicationController
  attr_accessor :sort_key
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
  def destroy
    review = Review.find(params[:id])
    review.destroy
    redirect_to movies_path
  end
  private
  def singleMovie
    @movie_service = MovieService.new
    @movie_service.single_movie(params[:id].to_s, true)
  end
end

