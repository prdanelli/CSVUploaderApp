require "csv"

class CsvUploader < CarrierWave::Uploader::Base
  storage :aws

  before :process, :validate
  before :cache, :store_original_filename
  after :store, :store_s3_url

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
  def filename
    @_filename ||= begin
      return unless original_filename.present?

      basename = File.basename(file.filename, ".#{file.extension}")

      "#{basename}-#{secure_token}.#{file.extension}"
    end
  end

  protected

  def secure_token(length = 16)
    model.csv_secure_token ||= SecureRandom.uuid
  end

  def store_original_filename(file)
    model.original_filename ||= file.original_filename if file.respond_to?(:original_filename)
  end

  def store_s3_url(_file)
    model.update_columns(s3_url: download_url(self.file.filename))
  end

  # Ensure that the ID column is unique for all CSV rows.
  # Please note, that for large CSVs this might need to be improved
  def validate(csv)
    file = File.open(csv.file)
    ids = CSV.parse(file, headers: true).map(&:to_h).map { |h| h["ID"] }

    return if ids.length == ids.uniq.length

    raise InvalidCsvError.new("Duplicate values were found in the ID column of #{csv.filename}")
  end
end
