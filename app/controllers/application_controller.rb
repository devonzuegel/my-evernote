class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :store_authtoken
  helper_method :auth_token

  private

  def auth_token
    current_user.auth_token || session[:auth_token] if current_user.present?
  end

  def store_authtoken
    return unless current_user.present?
    current_user.auth_token ||= session[:auth_token]
    current_user.save
  end

  def current_user
    from_devise  = super
    from_session = User.find(session[:current_user_id]) if session[:current_user_id].present?
    from_devise || from_session
  end
end
