class UsersController < ApplicationController
  before_action :authenticate_user!, :set_user

  def index
    @users = User.all
  end

  def show
    redirect_to :back unless @user == current_user
  end

  private

  def set_user
    @user = User.find(params[:id]) unless params[:id].nil?
  end
end
