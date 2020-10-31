require 'rails_helper'

RSpec.describe User, type: :model do
  describe "email validations" do
    it { should validate_presence_of(:email) }
    it { should allow_value("test@test.com").for(:email) }
    it { should_not allow_value("test").for(:email) }
    it { should_not allow_value("").for(:email) }
  end

  describe "password validations" do
    it { should validate_presence_of(:password) }
    it { should have_secure_password }
    it { should validate_length_of(:password).is_at_least(8).is_at_most(128) }
  end

  describe "associations" do
    it { should have_many(:csvs) }
  end
end
