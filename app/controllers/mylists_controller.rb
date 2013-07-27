class MylistsController < ApplicationController
  before_action :authorize, only: [:rename,:new, :show, :create, :edit, :update, :destroy]
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

  def destroy
    if !Api.exists?(:key => params[:p])
      render json: { m:"invalidAPIKey" }
      return
    end
    user = Api.where(:key => params[:p]).first.user
    if !Mylist.exists?(params[:mylist_id]) || Mylist.find(params[:mylist_id]).user_id != user.id
      render json: { m:"invalidMyListId" }
      return
    end
    Mylist.destroy(params[:mylist_id])
    render json: {m:"succeeded"}
  end

  def create
    if !Api.exists?(:key => params[:p])
      render json: { m:"invalidAPIKey" }
      return
    end
    user = Api.where(:key => params[:p]).first.user
    if user.mylists.exists?(:name => params[:mylist][:name])
      render json: {m:"overlapMyListName"}
      return
    end
    if params[:mylist][:name] == ""
      render json: {m:"invalidMyListName"}
      return
    end
#    user = Api.where(:key => params[:p]).first.user
    @mylist = Mylist.new(mylist_params)
    @mylist.user = current_user
    @mylist.save
    render json: {ret:@mylist,m:"succeeded"}
  end

  def edit
    @mylist = Mylist.find(params[:id])
  end

  def rename
    if !Api.exists?(:key => params[:p])
      render json: { m:"invalidAPIKey" }
      return
    end
    user = Api.where(:key => params[:p]).first.user
    if !Mylist.exists?(params[:mylist_id]) || Mylist.find(params[:mylist_id]).user_id != user.id
      render json: { m:"invalidMyListId" }
      return
    end
    if user.mylists.exists?(:name => params[:name])
      render json: {m:"overlapMyListName"}
      return
    end
    if params[:name] == ""
      render json: {m:"invalidMyListName"}
      return
    end

    mylist = Mylist.find(params[:mylist_id]).update(:name  => params[:name])
    render json:{ret:mylist,m:"succeeded"}
  end
=begin
  def update
    if !Api.exists?(:key => params[:p])
      render json: { m:"invalidAPIKey" }
      return
    end
    user = Api.where(:key => params[:p]).first.user
    if !Mylist.exists?(params[:mylist_id]) || Mylist.find(params[:mylist_id]).user_id != user.id
      render json: { m:"invalidMyListId" }
      return
    end
    @mylist = Mylist.find(params[:id])
    @mylist.update(mylist_params)
    redirect_to @mylist
  end
=end
  private
  def mylist_params
    params.require(:mylist).permit(:name)
  end
end
