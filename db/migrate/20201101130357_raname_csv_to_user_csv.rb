class RanameCsvToUserCsv < ActiveRecord::Migration[6.0]
  def change
    rename_table :csvs, :user_csvs
  end
end
