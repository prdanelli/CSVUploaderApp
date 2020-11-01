class UserCsv < ApplicationRecord
  belongs_to :user
  mount_uploader :csv, CsvUploader

  def data
    @_data ||= begin
      return unless persisted?

      # I would prefer to use `csv.download_url(csv.file.filename)`
      # however, the instructions required the URL to be saved
      data = open(s3_url).read

      CSV.parse(data)
    end
  end
end
