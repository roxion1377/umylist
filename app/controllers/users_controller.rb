class UsersController < ApplicationController
  def index
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user
      redirect_to users_path
    else
      render 'new'
    end
  end
  private
  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation)
  end
end
