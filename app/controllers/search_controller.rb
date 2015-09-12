class SearchController < ApplicationController
  def index
    @movie_service = MovieService.new
  end
  def show
    @movie_service = MovieService.new
    puts "============="
    puts :q.sub('+','%'))
    puts'bananapeach'
    puts "============="
    @movie_name = @movie_service.single_movie(:q)
    redirect_to  "/search/{movie['imdbID']}"
  end
  private
  def searcher_params
    params.require(:searcher).permit(:q)
end
end
