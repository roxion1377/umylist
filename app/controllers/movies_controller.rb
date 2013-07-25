class MoviesController < ApplicationController
  before_action :authorize, [:create]
  skip_before_filter :verify_authenticity_token
  def create
    if !Api.exists?(:key => params[:p])
      render json: { m:"invalidAPIKey" }
      return
    end
    user = Api.where(:key => params[:p]).first.user
    p = params[:movie]
    if !Mylist.exists?(p[:mylist_id]) || Mylist.find(p[:mylist_id]).user_id != user.id
      render json: { m:"invalidMyListId" }
      return
    end
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
