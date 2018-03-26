class WelcomeController < ApplicationController
  def index
    if logged_in?
      @user = User.find_by_id(session[:user_id])
      redirect_to "/users/#{session[:user_id]}"
    end
  end
end
