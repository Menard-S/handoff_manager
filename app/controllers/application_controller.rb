class ApplicationController < ActionController::Base
  helper_method :current_user
  helper :tasks
  before_action :set_current_user
  before_action :require_user

  private

  def set_current_user
    @user = User.find_by(id: session[:user_id]) if session[:user_id]
  end
  
  def current_user
    @user
  end
  
  def require_user
    unless @user
      redirect_to sign_in_path, alert: 'You must be signed in to access this page.'
    end
  end
end
