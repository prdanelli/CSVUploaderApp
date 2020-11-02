require 'rails_helper'

RSpec.describe UserCsv, type: :model do
  describe "association validations" do
    it { should belong_to(:user) }
  end

  describe "#data" do
    let(:user_csv) { create(:user_csv) }

    it "mounts the csv uploader" do
      expect(user_csv.methods).to include(:csv_cache)
    end

    it "returns an array of arrays" do
      expect(user_csv.data).to be_an(Array)
      expect(user_csv.data.count).to eq 2
    end

    it "has the csv headers as the first array" do
      expect(user_csv.data.first).to eq(["Book title", "Book author", "Date published", "ID", "Publisher name"])
    end
  end
end
