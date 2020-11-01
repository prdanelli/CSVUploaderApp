require "csv"

class CsvUploader < CarrierWave::Uploader::Base
  storage :aws

  before :process, :validate

  # Ensure that
  def validate(csv)
    file = File.open(csv.file)
    ids = CSV.parse(file, headers: true).map(&:to_h).map { |h| h["ID"] }

    return if ids.length == ids.uniq.length

    raise InvalidCsvError.new("Duplicate values were found in the ID column of #{csv.filename}")
  end

  def extension_whitelist
    %w(csv)
  end

  def content_type_whitelist
    ['text/csv']
  end

  # You can find a full list of custom headers in AWS SDK documentation on AWS::S3::S3Object
  def download_url(filename)
    url(response_content_disposition: %Q{attachment; filename="#{filename}"})
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end
end
