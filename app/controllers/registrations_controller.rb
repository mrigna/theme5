class RegistrationsController < Devise::RegistrationsController

  def set_groups
  end

  private

  def sign_up_params
    params.require(:user).permit(:username, :dg, :group, :email, :password, :password_confirmation)
  end

  def account_update_params
    params.require(:user).permit(:username, :dg, :group, :email, :password, :password_confirmation, :current_password)
  end
end