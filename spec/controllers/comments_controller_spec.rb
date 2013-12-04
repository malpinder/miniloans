require 'spec_helper'

describe CommentsController do
  let(:loan) { FactoryGirl.create(:loan) }

  describe "when not logged in" do
    it "forbids GET#new" do
      get :new, loan_id: loan.id
      expect(response).to redirect_to(new_user_session_path)
    end
    it "forbids POST#create" do
      post :create, loan_id: loan.id, comment: { text: "words" }
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe "when logged in" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in user
    end

    it "permits GET#new" do
      get :new, loan_id: loan.id
      expect(response).to be_success
    end
    it "permits POST#create" do
      post :create, loan_id: loan.id, comment: { text: "words" }
      expect(response).to redirect_to(loan_path(loan))
    end
  end

end
