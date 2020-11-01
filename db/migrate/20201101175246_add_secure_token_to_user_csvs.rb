class AddSecureTokenToUserCsvs < ActiveRecord::Migration[6.0]
  def change
    add_column :user_csvs, :csv_secure_token, :string
  end
end
