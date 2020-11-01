class UserCsv < ApplicationRecord
  belongs_to :user
  mount_uploader :csv, CsvUploader

  validates_with CsvValidator, on: :create

  def data
    @_data ||= begin
      return unless persisted?

      s3_url = csv.download_url(csv.file.filename)
      data = open(s3_url).read

      CSV.parse(data)
    end
  end
end
