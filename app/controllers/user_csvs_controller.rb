class UserCsvsController < ApplicationController
  before_action :ensure_user_logged_in!
  before_action :build_user_csv, only: %i(new create)

  def show
    @csv = UserCsv.find(params[:id])

    ensure_ownership!(@csv)
  end

  def create
    if @csv.update(permitted_params)
      return redirect_to(user_csv_path(@csv), flash: { success: "Your file was uploaded successfully" })
    end

    flash[:error] = "An error has occured"
    render :new
  end

  protected

  def ensure_user_logged_in!
    return if current_user.present?

    redirect_to root_path, flash: { error: "You must be logged into access this area" }
  end

  def ensure_ownership!(csv)
    return if csv.user == current_user

    raise ActiveRecord::RecordNotFound
  end

  def build_user_csv
    @csv ||= current_user.csvs.build
  end

  def permitted_params
    params.permit(:csv, :csv_cache, :user_id)
  end
end
