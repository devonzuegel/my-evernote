class EvernoteLoginController < ApplicationController
  rescue_from OAuth::Unauthorized, with: Proc.new { redirect_to root_path }

  def onboarding
    redirect_to new_user_registration_path unless user_signed_in?
    redirect_to root_path unless session[:auth_token].nil?
  end

  def callback
    session[:auth_token] = request.env['omniauth.auth']['credentials']['token']
    redirect_to root_path
  end

  def refresh
    current_user.sync unless current_user.nil?
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
