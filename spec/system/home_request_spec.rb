require 'rails_helper'

RSpec.describe "Home", type: :system do
  context "when the user comes to the root url" do
    before(:each) do
      visit root_path
    end

    it "shows them the welcome screen" do
      expect(page).to have_content("Welcome")
    end

    it "displays the login button" do
      expect(page).to have_selector("a.btn-login", text: "Login")
    end

    it "displays the login button" do
      expect(page).to have_selector("a.btn-register", text: "Register")
    end
  end
end
