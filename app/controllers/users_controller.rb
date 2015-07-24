class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    en_client = EvernoteClient.new(auth_token: auth_token, user_id: current_user.id)
    @obj = {
      notebooks: en_client.notebooks,
      # notebook_counts: en_client.notebook_counts,
      # en_user: en_client.user,
      notes_metadata: en_client.notes,
      first_note: en_client.first_note
    }
    # unless @user == current_user
    #   redirect_to :back, alert: 'Access denied.'
    # end
  end
end
