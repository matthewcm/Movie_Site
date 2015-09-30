class ReviewsController < ApplicationController
  before_action :ensure_log_in, only: [:create, :new]
  def index
  end

  def show
    @review = @movies.reviews.find(params[:id])
  end

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    #@review.omdb_id = MoviesController.movie['imdbID']

      if (@review.save)
        redirect_to movie_path(@review.movie_id)
    else
      render :new
    end
  end
  def destroy
    review = Review.find(params[:id])
     id = review.movie_id
    review.destroy
    redirect_to movie_path(id)
  end

  private
  def find_movie
    @movie = Movie.find(params[:id])
  end
  def review_params
    params.require(:review).permit(:body, :title, :movie_id, :user_id)
  end
  def singleMovie
    @movie_service = MovieService.new
    @movie_service.single_movie(params[:id].to_s, true)
  end

   def ensure_log_in
        if logged_in? == false
            redirect_to login_path
        end
   end
end
