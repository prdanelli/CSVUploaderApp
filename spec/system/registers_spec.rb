require 'rails_helper'

RSpec.describe "Registers", type: :system do
  before do
    driven_by(:rack_test)
  end

  context "when they do not enter valid details" do
    before(:each) do
      visit(register_path)

      within "#register-form" do
        fill_in "Email", with: "john smith"
        fill_in "Password", with: "1234"
        click_on("Register")
      end
    end

    it "displays an error message" do
      expect(page).to have_selector(".invalid-feedback", text: "Email is invalid")
      expect(page).to have_selector(".invalid-feedback", text: "Password is too short (minimum is 8 characters)")
    end

    it "displays the register form again" do
      expect(page).to have_current_path(register_path)
    end
  end

  context "when the email address is already in use" do
    let!(:user) { create(:user) }

    before(:each) do
      visit(register_path)

      within "#register-form" do
        fill_in "Email", with: user.email
        fill_in "Password", with: "12345678"
        click_on("Register")
      end
    end

    it "displays an error message" do
      expect(page).to have_selector(".invalid-feedback", text: "Email has already been taken")
    end

    it "displays the register form again" do
      expect(page).to have_current_path(register_path)
    end
  end

  describe "when they enter valid credentials" do
    let!(:user) { create(:user) }

    before(:each) do
      visit(register_path)

      within "#register-form" do
        fill_in "Email", with: "another-email@address.com"
        fill_in "Password", with: "12345678"
        click_on("Register")
      end
    end

    context "when they enter valid details" do
      it "logs them in" do
        expect(page).to have_selector(".alert-success")
      end

      it "takes them to the add new csv page" do
        expect(page).to have_current_path(new_user_csv_path)
      end
    end
  end

  describe "when the user is already logged in" do
    let(:user) { create(:user, email: "testing@testing.com" ) }

    before do
      login_as(user)
    end

    context "when the user goes back to the login page" do
      before do
        visit(register_path)
      end

      it "redirects themn to the user csvs page" do
        expect(page).to have_current_path(user_csvs_path)
      end
    end
  end
end
