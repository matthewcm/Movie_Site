class ReviewsController < ApplicationController
  def index
    @reviews = find_movie.reviews.new
  end

  def show
    @review = find_hotel.reviews.find(params[:id])
  end

  def edit
    @review = find_hotel.reviews.find(params[:id])
  end

  def update
    @review = find_hotel.reviews.find(params[:id])
    @review.update(review_params)
    flash[:notice] = "The review was updated. "
    redirect_to hotel_review_path(@hotel, @review)
  end

  def new
    @hotel = Hotel.find(params[:hotel_id])
    @review = @hotel.reviews.new
  end

  def create
    @hotel = find_hotel
    @review = @hotel.reviews.new(review_params)
      if (@hotel.save)
      redirect_to hotel_path(@hotel)
    else
      render :new
    end
  end
  def destroy
    hotel = Hotel.find(params[:id])
    hotel.destroy
    redirect_to "/hotels"
  end

  private
  def find_movie
    @movie = Movie.find(params[:id])
  end
  def review_params
    params.require(:review).permit(:body, :title)
  end
   def ensure_log_in
        if logged_in? == false
            redirect_to login_path
        end
   end
end
