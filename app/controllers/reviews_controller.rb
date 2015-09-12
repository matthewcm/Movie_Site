class ReviewsController < ApplicationController
  def index
  end

  def show
    @review = @movies.reviews.find(params[:id])
  end

  def edit
    @review = @movies.reviews.find(params[:id])
  end

  def update
    @review = reviews.find(params[:id])
    @review.update(review_params)
    flash[:notice] = "The review was updated. "
    redirect_to review_path(@movie, @review)
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
    @movies.review.destroy
    redirect_to movie_path
  end

  private
  def find_movie
    @movie = Movie.find(params[:id])
  end
  def review_params
    params.require(:review).permit(:body, :title, :movie_id)
  end
  def singleMovie
    @movie_service = MovieService.new
    @movie_service.single_movie(params[:id].to_s, true)
  end
   # def ensure_log_in
   #      if logged_in? == false
   #          redirect_to login_path
   #      end
   # end
end
