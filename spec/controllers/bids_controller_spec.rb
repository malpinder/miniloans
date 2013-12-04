require 'spec_helper'

describe BidsController do
  let(:loan) { FactoryGirl.create(:loan) }

  describe "when not logged in" do
    it "forbids POST#create" do
      post :create, loan_id: loan.id, bid: { amount: 500 }
      expect(response).to redirect_to(new_user_session_path)
    end
  end


end
