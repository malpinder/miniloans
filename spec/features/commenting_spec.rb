require 'spec_helper'

feature "Leaving a comment" do

  let!(:loan) { FactoryGirl.create(:loan) }

  describe "when not logged in" do
    it "does not show leave a comment links" do
      visit loan_path(loan)
      expect(page).to_not have_link("Add comment")
    end
  end

  describe "when logged in" do
    let(:user) { User.create!(username: "Jane", email: "jane@example.com", password: 'password', password_confirmation: 'password') }

    before do
      login_as user
    end
    describe "directly on the loan" do
      it "displays the comment on the top level" do
        visit loan_path(loan)
        click_link "Add comment"

        fill_in "Text", with: "My comment"
        click_button "Create Comment"

        expect(current_path).to eq loan_path(loan)
        within "ul#comments:first-child" do
          expect(page).to have_content "Jane wrote:"
          expect(page).to have_content "My comment"
        end
      end
    end

    describe "in reply to another comment" do
      let!(:other_user) { User.create!(username: "Chris", email: "chris@example.com", password: 'password', password_confirmation: 'password')}
      let!(:comment)    { Comment.create!(user: other_user, loan: loan, text: "An existing comment") }

      it "nests the reply under the comment" do
        visit loan_path(loan)
        click_link "Reply"

        fill_in "Text", with: "My comment"
        click_button "Create Comment"

        expect(current_path).to eq loan_path(loan)

        within "li#comment_#{comment.id}" do
          expect(page).to have_content "Jane wrote:"
          expect(page).to have_content "My comment"
        end
      end
    end
  end

end
