class AddCsvToCsv < ActiveRecord::Migration[6.0]
  def change
    add_column :csvs, :csv, :string
  end
end
