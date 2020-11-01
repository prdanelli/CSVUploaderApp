class AddOriginalFilenameToUserCsvs < ActiveRecord::Migration[6.0]
  def change
    add_column :user_csvs, :original_filename, :string
  end
end
