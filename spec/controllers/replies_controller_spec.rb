require 'spec_helper'

describe RepliesController do
  let(:comment) { FactoryGirl.create(:comment) }

  describe "when not logged in" do
    it "forbids GET#new" do
      get :new, comment_id: comment.id
      expect(response).to redirect_to(new_user_session_path)
    end
    it "forbids POST#create" do
      post :create, comment_id: comment.id, comment: { text: "words" }
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe "when logged in" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in user
    end

    it "permits GET#new" do
      get :new, comment_id: comment.id
      expect(response).to be_success
    end
    it "permits POST#create" do
      post :create, comment_id: comment.id, comment: { text: "words" }
      expect(response).to redirect_to(loan_path(comment.loan))
    end
  end

end
