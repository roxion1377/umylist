class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  private
  def current_user
#    @current_user ||= User.find(session[:user_id]) if session[:user_id]
    @current_user ||= Api.where(:key => params[:p]).first.user if params[:p] && Api.exists?(:key=>params[:p])
  end
  def authorize
#    redirect_to signin_path if current_user.nil?
  end
  helper_method :current_user
end
