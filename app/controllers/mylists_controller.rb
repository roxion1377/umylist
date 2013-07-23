class MylistsController < ApplicationController
  before_action :authorize, only: [:new, :create, :edit, :update, :destroy]

  def index
    @mylists = Mylist.where(:user_id => current_user)
  end

  def show
    @mylist = Mylist.find(params[:id])
    @movies = Movie.where(:mylist_id => params[:id])
  end

  def new
    @mylist = Mylist.new
  end

  def create
    @mylist = Mylist.new(mylist_params)
    @mylist.user = current_user
    @mylist.save
    redirect_to @mylist
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
