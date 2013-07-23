class MoviesController < ApplicationController
  before_action :authorize, [:new,:create]
  def new
    @movie = Movie.new
  end
  def create
    @movie = Movie.new(movie_params)
    @movie.user = current_user
    @movie.save
    respond_to do |format|
      format.json { render json: @movie }
    end
  end
  private
  def movie_params
    params.require(:movie).permit(:mylist_id,:smid)
  end
end
