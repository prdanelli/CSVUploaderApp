require 'rails_helper'

RSpec.describe "Logins", type: :system do
  before do
    driven_by(:rack_test)
  end

  context "when they do not enter valid login details" do
    before(:each) do
      visit(login_path)

      within "#login-form" do
        fill_in "Email", with: "john smith"
        fill_in "Password", with: "1234"
        click_on("Login")
      end
    end

    it "displays an error message" do
      expect(page).to have_selector(".alert-danger")
    end

    it "displays the login form again" do
      expect(page).to have_current_path(login_path)
    end
  end

  describe "when a user is not registered" do
    let!(:user) { create(:user) }

    before(:each) do
      visit(login_path)

      within "#login-form" do
        fill_in "Email", with: "john@smith.com"
        fill_in "Password", with: "12345678"
        click_on("Login")
      end
    end

    context "when they enter valid login details" do
      it "displays an error message" do
        expect(page).to have_selector(".alert-danger")
      end

      it "displays the login form again" do
        expect(page).to have_current_path(login_path)
      end
    end
  end

  describe "when a user is registered" do
    let!(:user) { create(:user) }

    before(:each) do
      visit(login_path)

      within "#login-form" do
        fill_in "Email", with: user.email
        fill_in "Password", with: "12345678"
        click_on("Login")
      end
    end

    context "when they enter valid login details" do
      it "logs them in" do
        expect(page).to have_selector(".alert-success")
      end

      it "takes them to their csvs" do
        expect(page).to have_current_path(user_csvs_path)
      end
    end
  end

  describe "when the user is already logged in" do
    let(:user) { create(:user) }

    before do
      login_as(user)
    end

    context "when the user goes back to the login page" do
      before do
        visit(login_path)
      end

      it "redirects themn to the user csvs page" do
        expect(page).to have_current_path(user_csvs_path)
      end
    end
  end
end
