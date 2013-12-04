require 'spec_helper'

describe LoansController do
  let(:loan) { FactoryGirl.create(:loan) }

  describe "when not logged in" do
    it "permits GET#index" do
      get :index
      expect(response).to be_success
    end
    it "permits GET#show" do
      get :show, id: loan.id
      expect(response).to be_success
    end

    it "forbids GET#new" do
      get :new
      expect(response).to redirect_to(new_user_session_path)
    end
    it "forbids POST#create" do
      post :create, id: loan.id, loan: { amount: 1000 }
      expect(response).to redirect_to(new_user_session_path)
    end
    it "forbids GET#edit" do
      get :edit, id: loan.id
      expect(response).to redirect_to(new_user_session_path)
    end
    it "forbids PUT#update" do
      put :update, id: loan.id, loan: { amount: 1000 }
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe "when logged in" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in user
    end
    it "permits GET#index" do
      get :index
      expect(response).to be_success
    end
    it "permits GET#show" do
      get :show, id: loan.id
      expect(response).to be_success
    end

    it "forbids GET#new" do
      get :new
      expect(response).to redirect_to(root_path)
    end
    it "forbids POST#create" do
      post :create, id: loan.id, loan: { amount: 1000 }
      expect(response).to redirect_to(root_path)
    end
    it "forbids GET#edit" do
      get :edit, id: loan.id
      expect(response).to redirect_to(root_path)
    end
    it "forbids PUT#update" do
      put :update, id: loan.id, loan: { amount: 1000 }
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
    it "permits GET#show" do
      get :show, id: loan.id
      expect(response).to be_success
    end

    it "permits GET#new" do
      get :new
      expect(response).to be_success
    end
    it "permits POST#create" do
      expect {
        post :create, loan: { amount: 1000 }
      }.to change(Loan, :count).by(1)
      expect(response).to be_redirect
    end
    it "permits GET#edit" do
      get :edit, id: loan.id
      expect(response).to be_success
    end
    it "permits PUT#update" do
      put :update, id: loan.id, loan: { amount: 1000 }
      expect(response).to redirect_to loan_path(loan)
    end
  end

end
