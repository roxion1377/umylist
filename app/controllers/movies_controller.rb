class MoviesController < ApplicationController
  before_action :authorize, [:create,:remove]
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
    if user.mylists.find(p[:mylist_id]).movies.exists?(:sm_id=>p[:sm_id])
      render json: {m:"overlapSmId"}
      return
    end
    @movie = Movie.new(movie_params)
    @movie.user = current_user
    @movie.save
    render json: {ret:@movie,m:"succeeded"}
  end
  def remove
    if !Api.exists?(:key => params[:p])
      render json: { m:"invalidAPIKey" }
      return
    end
    user = Api.where(:key => params[:p]).first.user
    if !Mylist.exists?(params[:mylist_id]) || Mylist.find(params[:mylist_id]).user_id != user.id
      render json: { m:"invalidMyListId" }
      return
    end
    Movie.where(:mylist_id => params[:mylist_id],:sm_id => params[:sm_id]).destroy_all
    render json: {m:"succeeded"}
  end
  private
  def movie_params
    params.require(:movie).permit(:mylist_id,:sm_id,:thread_id)
  end
end
