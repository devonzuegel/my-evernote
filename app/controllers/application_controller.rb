class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :store_authtoken
  helper_method :auth_token

  private

  def auth_token
    current_user.auth_token || session[:auth_token] unless current_user.nil?
  end

  def store_authtoken
    return if current_user.nil?
    current_user.auth_token ||= session[:auth_token]
    current_user.save
  end

  def current_user
    from_devise  = super
    from_session = User.find(session[:current_user_id]) unless session[:current_user_id].nil?
    from_devise || from_session
  end
end
