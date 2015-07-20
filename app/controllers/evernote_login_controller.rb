class EvernoteLoginController < ApplicationController
  rescue_from OAuth::Unauthorized, with: Proc.new { redirect_to root_path }

  def onboarding
    redirect_to new_user_registration_path unless user_signed_in?
  end

  def callback
    session[:auth_token] = request.env['omniauth.auth']['credentials']['token']
    session[:dry_run] = true
    redirect_to root_path
  end

  def oauth_failure
    redirect_to root_path
  end

  def logout
    session.clear
    redirect_to root_path
  end

end
