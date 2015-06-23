class UsersController < ApplicationController
  before_action :check_user
  
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end
  
  private
  
  def check_user
    unless current_user.username == "michele"
        redirect_to root_path, :alert => "Access denied."
    end
  end
  
end