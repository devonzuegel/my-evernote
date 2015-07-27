class EvernoteLoginController < ApplicationController
  rescue_from OAuth::Unauthorized, with: proc { redirect_to root_path }

  def onboarding
    redirect_to new_user_registration_path unless user_signed_in?
    redirect_to root_path if session[:auth_token].present?
  end

  def callback
    session[:auth_token] = request.env['omniauth.auth']['credentials']['token']
    redirect_to root_path
  end

  def refresh
    current_user.sync if current_user.present?
    redirect_to :back, flash: { info: 'Sync complete!' }
  end

  def oauth_failure
    redirect_to root_path
  end

  def logout
    session.clear
    redirect_to root_path
  end
end
