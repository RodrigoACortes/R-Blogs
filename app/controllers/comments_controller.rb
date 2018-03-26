class CommentsController < ApplicationController
	def index
		@comments = Comment.all
		@user = User.find_by_id(session[:user_id])
	end

	def new
		@comment = Comment.new
		@blog = Blog.find_by_id(params[:id])
		@user = User.find_by_id(session[:user_id])
	end

	def create
		@user = User.find_by_id(session[:user_id])
		@blog = Blog.find(params[:blog_id])
		@comment = @blog.comments.new(comment_params)
		@comment.user_id = @user.id
		@comment.blog_id = @blog.id
		if @comment.save
			flash[:message] = 'Comment was created'
			redirect_back(fallback_location: "/blogs/#{@blog.id}")
		else
			flash[:message] = 'Try again'
			redirect_to "/blogs/#{@blog.id}/comments/new"
		end
	end

	def show
		@user = User.find_by_id(session[:user_id])
		@blog = Blog.find_by_id(params[:id])
		@comment = Comment.find_by_id(params[:id])
	end

	def edit
		@user = User.find_by_id(session[:user_id])
		@blog = Blog.find_by_id(params[:id])
		@comment = Comment.find_by_id(params[:id])
	end

	def update
		@user = User.find_by_id(session[:user_id])
		@blog = Blog.find_by_id(params[:id])
		@comment = Comment.find_by_id(params[:id])
		@comment.user_id = @user.id
		# @comment.blog_id = @blog.id
		if @comment.update(comment_params)
			flash[:message] = 'Blog updated'
			redirect_to "/blogs/#{@comment.blog_id}"
		else
			flash[:message] = 'try again'
			redirect_to "/blogs/#{@blog}/comments/#{@comment.id}/edit"
		end
	end

	def destroy
		@user = User.find_by_id(session[:user_id])
		@blog = Blog.find_by_id(params[:id])
		@comment = Comment.find_by_id(params[:id])
		@comment.destroy
		redirect_back(fallback_location: "/users/#{@user.id}")
	end

	private
	def comment_params
		params.require(:comment).permit(:content, :blog_id, :user_id)
	end
end
