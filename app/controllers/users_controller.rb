class UsersController < ApplicationController
  def index
    @comment = Comment.find_by_id(params[:id])
    @users = User.all
    if logged_in?
      @user = User.find_by_id(session[:user_id])
    end
  end

  def new
    @user = User.new
    if logged_in?
      redirect_to "/users/#{session[:user_id]}"
    end
  end

  def create
    user = User.new(user_params)
    if user.save
      flash[:message] = 'Succes, Please log in.'
      redirect_back(fallback_location: new_user_path)
    else
      flash[:message] = 'Username already taken'
      redirect_to new_user_path
    end
  end

  def show
    @comment = Comment.find_by_id(params[:id])
    @user = User.find_by_id(params[:id])
    @blog = Blog.find_by_id(params[:id])
    @comment = Comment.find_by_id(params[:id])
  end

  def edit
    @user = User.find_by_id(session[:user_id])
  end

  def update
    @user = User.find_by_id(session[:user_id])
  		if @user.update(user_params)
  			flash[:message] = 'Your account was succesfully updated!'
  			redirect_to "/users/#{@user.id}"
  		else
  			flash[:message] = 'try again'
  			redirect_back(fallback_location: user_path)
  		end
  end

  def destroy
    @user = User.find_by_id(params[:id])
    @user.destroy
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
