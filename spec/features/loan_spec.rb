require 'spec_helper'

feature "Loans" do

  let!(:loan) { FactoryGirl.create(:loan) }
  let(:user)  { FactoryGirl.create(:user, username: "Jane") }
  let(:admin) { FactoryGirl.create(:user, :is_admin, username: "Admin") }

  describe "as a user" do

    before do
      login_as user
    end

    it "lets you view a loan" do
      visit loan_path(loan)

      expect(page).to have_content "A loan"
    end

    it "does not let you edit loans" do
      visit loan_path(loan)
      expect(page).to have_no_link "Edit"
    end
    it "does not let you create loans" do
      visit loans_path
      expect(page).to have_no_link "New Loan"
    end
  end

  describe "as an admin" do

    before do
      login_as admin
    end

    it "shows links to edit the loan" do
      visit loan_path(loan)

      expect(page).to have_content "A loan"
      expect(page).to have_link "Edit"
    end

    it "allows editing a loan" do
      visit loan_path(loan)
      click_link "Edit"

      fill_in "Title", with: "An edited loan"
      click_button "Update Loan"

      expect(current_path).to eq loan_path(loan)
      expect(page).to have_content "An edited loan"
    end

    it "allows creating a new loan" do
      visit loans_path
      click_link "New Loan"

      fill_in "Title", with: "A new loan"
      fill_in "Amount", with: "100"
      click_button "Create Loan"

      expect(page).to have_content "A new loan"
      expect(page).to have_content "Amount: 100"
    end
  end
end
