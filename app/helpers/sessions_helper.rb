module SessionsHelper
  #skip_before_action :login_required, only: %i[ new create ]
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    current_user.present?
  end
end
