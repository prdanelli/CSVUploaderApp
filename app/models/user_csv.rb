class UserCsv < ApplicationRecord
  belongs_to :user
  mount_uploader :csv, CsvUploader
end
