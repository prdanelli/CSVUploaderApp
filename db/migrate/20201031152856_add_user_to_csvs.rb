class AddUserToCsvs < ActiveRecord::Migration[6.0]
  def change
    change_table :csvs do |t|
      t.belongs_to :user
    end
  end
end
