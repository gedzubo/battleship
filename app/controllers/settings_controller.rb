class SettingsController < ApplicationController
  def show
  end

  def update
    if params[:change] == "password"
      update_password
    else
      update_username
    end
  end

  private

  def update_password
    unless Current.user.authenticate(params[:current_password])
      return redirect_to settings_path, alert: "Current password is incorrect."
    end

    if Current.user.update(params.permit(:password, :password_confirmation))
      redirect_to settings_path, notice: "Password updated."
    else
      redirect_to settings_path, alert: Current.user.errors.full_messages.to_sentence
    end
  end

  def update_username
    if Current.user.update(params.require(:user).permit(:username))
      redirect_to settings_path, notice: "Username updated."
    else
      redirect_to settings_path, alert: Current.user.errors.full_messages.to_sentence
    end
  end
end
