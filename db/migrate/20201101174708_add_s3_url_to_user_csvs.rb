class AddS3UrlToUserCsvs < ActiveRecord::Migration[6.0]
  def change
    add_column :user_csvs, :s3_url, :string
  end
end
