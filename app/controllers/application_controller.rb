class ApplicationController < ActionController::Base

  # make current_user available in views
  helper_method :current_user

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    redirect_to login_path, alert: 'You must be logged in to access this page.' if current_user.nil?
  end

  def authorize_edit_profile
    redirect_to root_path, alert: 'You can only edit your own profile.' if params[:id] != session[:user_id]
  end 
end
