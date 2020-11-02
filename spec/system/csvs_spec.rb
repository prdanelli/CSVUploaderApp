require 'rails_helper'

RSpec.describe "Csvs", type: :system do
  let(:user) { create(:user) }

  before do
    driven_by(:rack_test)
  end

  describe "when the user has no csvs" do
    before do
      login_as(user)
      visit(user_csvs_path)
    end

    it "shows them a message" do
      expect(page).to have_content("You dont have any uploaded CSVs yet")
    end
  end

  describe "when the user has a csv" do
    let!(:csv) { create(:user_csv, user: user) }

    before do
      login_as(user)
      visit(user_csvs_path)
    end

    it "displays the csv in a table" do
      expect(page).to have_selector("table.user-csvs")
      expect(page).to have_selector("tr.csv-row", count: 1, text: csv.original_filename)
    end

    context "when the user pressed the view button" do
      before do
        find("a.view-csv").click
      end

      it "takes the user to the show page" do
        expect(page).to have_current_path(user_csv_path(csv))
      end

      it "displays the name of the csv" do
        expect(page).to have_selector("h1", text: csv.original_filename, count: 1)
      end
    end

    context "when the user presses the delete button" do
      before do
        find("a.delete-csv").click
      end

      it "reloads the page" do
        expect(page).to have_current_path(user_csvs_path)
      end

      it "displays a success message" do
        expect(page).to have_selector(".alert-success", text: "Your file was deleted successfully")
      end

      it "deletes the csv" do
        expect(page).not_to have_selector("table.user-csvs")
        expect(page).not_to have_selector("tr.csv-row", count: 1, text: csv.original_filename)
        expect(UserCsv.find_by(id: csv.id)).to be_nil
      end
    end
  end

  describe "when adding a new csv" do
    before do
      login_as(user)
      visit(new_user_csv_path)
    end

    context "when the user goes to the page" do
      it "displays a form" do
        expect(page).to have_selector("#new_user_csv", count: 1, visible: true)
      end
    end

    describe "when the user fills out the form" do
      before do
        within("#new_user_csv") do
          # Visible false is a hack because otherwise I cannot seem to find the file input
          # possibly because of the bootstrap form file field replacement
          attach_file("user_csv_csv", file, visible: false)
          click_button("Submit")
        end
      end

      context "when they add a valid csv" do
        let(:file) { Rails.root.join("spec", "fixtures", "files", "valid.csv") }

        it "displays an success message"do
          expect(page).to have_selector(".alert-success", text: "Your file was uploaded successfully")
        end

        it "takes the user to the show csv page" do
          expect(page).to have_current_path(user_csv_path(user.csvs.last))
        end

        it "displays the correct number of rows" do
          expect(page).to have_selector(".csv-entry-row", count: 1)
        end

        it "displays the csv original filename" do
          expect(page).to have_selector("h1", text: user.csvs.last.original_filename, count: 1)
        end
      end

      context "when the csv is invalid" do
        let(:file) { Rails.root.join("spec", "fixtures", "files", "invalid.csv") }

        it "displays the same page" do
          expect(page).to have_current_path(new_user_csv_path)
        end

        it "displays an error message"do
          message = "Duplicate values were found in the ID column of invalid.csv"
          expect(page).to have_selector(".alert-danger", text: message)
        end
      end

      context "when the file is not a valid csv" do
        let(:file) { Rails.root.join("spec", "fixtures", "files", "not-a-csv.txt") }

        it "displays the form" do
          expect(page).to have_selector("#new_user_csv")
        end

        it "displays an error message" do
          expect(page).to have_selector(".alert-danger", text: "An error has occured")
          expect(page).to have_content('Csv You are not allowed to upload "txt" files, allowed types: csv')
        end
      end
    end
  end
end
