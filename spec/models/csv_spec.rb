require 'rails_helper'

RSpec.describe UserCsv, type: :model do
  describe "association validations" do
    it { should belong_to(:user) }
  end
end
