class UsersController < ApplicationController
  before_action :check_user
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def edit
  end

  def show
  end

  def update
    @user.update(dg: params[:user][:dg]) unless params[:user][:dg].blank?
    @user.update(group: params[:user][:group]) unless params[:user][:group].blank?
    redirect_to user_path
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_path, notice: 'Theme was successfully destroyed.' }
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def check_user
    unless current_user.username == "michele"
        redirect_to root_path, :alert => "Access denied."
    end
  end

end