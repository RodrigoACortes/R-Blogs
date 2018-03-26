class SessionsController < ApplicationController

  def new
  end

  def create
    @user = User.find_by_username(params[:username])
		if @user && @user.authenticate(params[:password])
			session[:user_id] = @user.id
			flash[:message] = 'You logged in successfully'
			redirect_to "/users/#{session[:user_id]}"
		else
			flash[:message] = 'try again'
			redirect_to root_path
		end
  end

  def destroy
    session[:user_id] = nil
    flash[:message] = 'You logged out succesfully'
    redirect_to root_path
  end

end
