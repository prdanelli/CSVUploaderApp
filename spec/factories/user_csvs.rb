FactoryBot.define do
  factory :user_csv do
    csv { Rack::Test::UploadedFile.new(Rails.root.join("spec", "fixtures", "files", "valid.csv"), "text/csv") }

    before(:create) do |record|
      record.user = create(:user, "test-#{SecureRandom.uuid}@example.com") if record.user.blank?
    end
  end
end
