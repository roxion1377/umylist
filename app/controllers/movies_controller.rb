class MoviesController < ApplicationController
  before_action :authorize, [:new,:create]
  def new
    @movie = Movie.new
  end
  def create
    p params
    @movie = Movie.new(movie_params)
    @movie.user = current_user
    if @movie.save
      render json: @movie
    else
      p @movie.errors
      render "new"
    end
  end
  private
  def movie_params
    params.require(:movie).permit(:mylist_id,:sm_id,:thread_id)
  end
end
