require 'spec_helper'

describe BidsController do
  let(:loan) { FactoryGirl.create(:loan) }
  let(:bid) { FactoryGirl.create(:bid, loan: loan) }

  describe "when not logged in" do
    it "forbids POST#create" do
      post :create, loan_id: loan.id, bid: { amount: 500 }
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe "when logged in" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in user
    end
    it "forbids GET#index" do
      get :index
      expect(response).to redirect_to(root_path)
    end
    it "permits POST#create" do
      post :create, loan_id: loan.id, bid: { amount: 1000 }
      expect(response).to redirect_to loan_path(loan)
    end
    it "forbids GET#edit" do
      get :edit, id: bid.id
      expect(response).to redirect_to(root_path)
    end
    it "forbids PUT#update" do
      put :update, id: bid.id, bid: { amount: 1000 }
      expect(response).to redirect_to(root_path)
    end
  end

  describe "when an admin" do
    let(:user) { FactoryGirl.create(:user, :is_admin) }
    before do
      sign_in user
    end
    it "permits GET#index" do
      get :index
      expect(response).to be_success
    end
    it "permits GET#edit" do
      get :edit, id: bid.id
      expect(response).to be_success
    end
    it "permits PUT#update" do
      put :update, id: bid.id, bid: { amount: 1000 }
      expect(response).to redirect_to bids_path
    end
  end

end
