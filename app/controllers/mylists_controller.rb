class MylistsController < ApplicationController
  before_action :authorize, only: [:new, :show, :create, :edit, :update, :destroy]
  skip_before_filter :verify_authenticity_token
  def index
    @mylists = Mylist.where(:user_id => current_user)
    respond_to do |format|
      format.html
      format.json {render json: @mylists}
    end
  end

  def show
    @mylist = User.find(current_user).mylists.find(params[:id])
    @movies = Movie.where(:mylist_id => params[:id])
    respond_to do |f|
      f.html
      f.json {render json:@movies}
    end
  end

  def new
    @mylist = Mylist.new
  end

  def create
    if !Api.exists?(:key => params[:p])
      render json: { m:"invalidAPIKey" }
      return
    end
    user = Api.where(:key => params[:p]).first.user
    @mylist = Mylist.new(mylist_params)
    @mylist.user = current_user
    @mylist.save
    render json: @mylist
  end

  def edit
    @mylist = Mylist.find(params[:id])
  end

  def update
    @mylist = Mylist.find(params[:id])
    @mylist.update(mylist_params)
    redirect_to @mylist
  end

  private
  def mylist_params
    params.require(:mylist).permit(:name)
  end
end
