module ApplicationHelper
  def onboarding?
    params[:controller] == 'evernote_login' && params[:action] == 'onboarding'
  end

end