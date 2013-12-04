require 'spec_helper'

feature "Bidding on a loan" do

  let!(:loan) { FactoryGirl.create(:loan, amount: 500) }

  it "shows the amount remaining when first visiting a loan" do
    visit loan_path(loan)
    expect(page).to have_content "Amount remaining: 500"
  end

  describe "when logged in" do
    let(:user) { FactoryGirl.create(:user) }

    before do
      # login_as is a Warden/Devise helper method that bypasses the login page.
      login_as user
    end

    it "lets you place a bid on a loan" do
      visit loan_path(loan)
      fill_in "Amount to bid", with: "100"
      click_button "Place bid"

      expect(current_path).to eq loan_path(loan)
      expect(page).to have_content "Amount remaining: 400"
    end
  end

  describe "when not logged in" do
    it "does not show the bid form" do
      visit loan_path(loan)
      expect(page).to have_no_selector "form#new_bid"
    end
  end

end
