class UserCsv < ApplicationRecord
  REMOTE_URL = "https://enbrtwpe490a7.x.pipedream.net".freeze

  belongs_to :user
  mount_uploader :csv, CsvUploader

  def data
    @_data ||= begin
      return unless persisted?

      # I would prefer to use `csv.download_url(csv.file.filename)`
      # however, the instructions required the URL to be saved
      data = URI(s3_url).open.read

      CSV.parse(data)
    end
  end

  def notify_remote!
    Net::HTTP.post_form(URI.parse(REMOTE_URL), { s3_url: s3_url })
  end
end
