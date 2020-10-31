require 'rails_helper'

RSpec.describe Csv, type: :model do
  describe "association validations" do
    it { should belong_to(:user) }
  end
end
