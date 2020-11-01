class UserCsvsController < ApplicationController
  before_action :ensure_user_logged_in!
  before_action :build_user_csv, only: %i(new create)
  before_action :find_csv, only: %i(show destroy)

  rescue_from InvalidCsvError, with: :rescue_invalid_csv_error

  def destroy
    @csv.destroy!
    redirect_to user_csvs_path, flash: { success: "Your file was deleted successfully" }
  end

  def create
    if @csv.update(permitted_params)
      return redirect_to(user_csv_path(@csv), flash: { success: "Your file was uploaded successfully" })
    end

    flash[:error] = "An error has occured"
    render :new
  end

  protected

  def find_csv
    @csv = current_user.csvs.find(params[:id])
  end

  def ensure_user_logged_in!
    return if current_user.present?

    redirect_to root_path, flash: { error: "You must be logged into access this area" }
  end

  def build_user_csv
    @csv ||= current_user.csvs.build
  end

  def permitted_params
    params.require(:user_csv).permit(:csv, :csv_cache, :user_id)
  end

  def rescue_invalid_csv_error(error)
    redirect_to new_user_csv_path, flash: { error: error.message }
  end
end
