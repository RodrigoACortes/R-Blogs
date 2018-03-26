class BlogsController < ApplicationController
  def index
    @blogs = Blog.all
    @user = User.find_by_id(session[:user_id])
  end

  def new
    @user = User.find_by_id(session[:user_id])
    @blog = Blog.new
  end

  def create
    user = User.find(session[:user_id])
    @user = User.find_by_id(session[:user_id])
    blog = Blog.new(blog_params)
    blog.user_id =user.id
    if blog.save
      flash[:message] = 'Blog created'
      redirect_to "/users/#{@user.id}"
    else
      flash[:message] = 'Try again'
      redirect_to new_blog_path
    end
  end

  def show
    @blog = Blog.find_by_id(params[:id])
    @blog_user = @blog.user_id
    if current_user
        @user = User.find_by_id(session[:user_id])
      else
        @userp = User.find_by_id(@blog_user)
    end
  end

  def edit
    @user = User.find_by_id(session[:user_id])
    @blog = Blog.find_by_id(params[:id])
  end

  def update
    @blog = Blog.find_by_id(params[:id])
    @user = User.find_by_id(session[:user_id])
    if current_user.id == @blog.user_id
      if @blog.update(blog_params)
        flash[:message] = 'Blog updated'
        redirect_to "/blogs/#{@blog.id}"
        return
      else
        flash[:message] = 'try again'
        redirect_to "/blogs/#{@blog.id}/edit"
        return
      end
    end
    flash[:message] = "You do not have access"
      render root_path
  end

  def destroy
    @blog = Blog.find_by_id(params[:id])
    @blog.destroy
    redirect_to root_path
  end

  private

    def blog_params
    	params.require(:blog).permit(:title, :content, :user_id)
    end

end
