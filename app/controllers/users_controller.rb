class UsersController < ApplicationController
  before_action :build_user, only: %i(new create)
  before_action :logged_in?, only: :new

  def create
    if @user.update(permitted_params)
      session[:user_id] = @user.id

      return redirect_to(new_user_csv_path, flash: { success: "Your account was created successfully" })
    end

    render :new, flash: { error: "An error occured" }
  end

  protected

  def permitted_params
    params.require(:user).permit(:email, :password)
  end

  def build_user
    @user ||= User.new
  end

  def logged_in?
    return if current_user.blank?

    redirect_to user_csvs_path
  end
end
