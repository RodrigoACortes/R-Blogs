class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  rescue_from Exception, :with => :render_404

  def current_user
  	current_user = User.find_by_id(session[:user_id])
  end

  helper_method :current_user, :logged_in?

  def logged_in?
  	current_user != nil
  end

private

def render_404(exception = nil)
  logger.info "Exception, redirecting: #{exception.message}" if exception
  redirect_to root_path
end
end
