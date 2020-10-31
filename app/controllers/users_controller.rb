class UsersController < ApplicationController
  before_action :build_user, only: %i(new create)

  def create
    if @user.update(permitted_params)
      @user.save
      session[:user_id] = @user.id

      return redirect_to user_csvs_path(@user)
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
end
