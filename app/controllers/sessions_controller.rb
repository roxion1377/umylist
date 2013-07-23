class SessionsController < ApplicationController
  def create
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to user
    else
      render 'new'
    end
  end
  def new
  end
  def destroy
    session[:user_id] = nil
  end
end
