require 'spec_helper'

describe UsersController do
  let!(:user) { FactoryGirl.create(:user, username: "Lou") }

  describe "when not logged in" do
    it "forbids GET#index" do
      get :index
      expect(response).to redirect_to(new_user_session_path)
    end
    it "forbids GET#show" do
      get :show, id: user.id
      expect(response).to redirect_to(new_user_session_path)
    end

    it "forbids GET#edit" do
      get :edit, id: user.id
      expect(response).to redirect_to(new_user_session_path)
    end
    it "forbids PUT#update" do
      put :update, id: user.id, user: { username: "l33t_H4xx0r" }
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe "when logged in" do
    let(:current_user) { FactoryGirl.create(:user) }
    before do
      sign_in current_user
    end
    it "forbids GET#index" do
      get :index
      expect(response).to redirect_to(root_path)
    end

    it "forbids GET#show on another" do
      get :show, id: user.id
      expect(response).to redirect_to(root_path)
    end

    it "forbids GET#edit on another" do
      get :edit, id: user.id
      expect(response).to redirect_to(root_path)
    end
    it "forbids PUT#update on another" do
      put :update, id: user.id, user: { username: "l33t_H4xx0r" }
      expect(response).to redirect_to(root_path)
    end

    it "permits GET#show on the self" do
      get :show, id: current_user.id
      expect(response).to be_success
    end

    it "permits GET#edit on the self" do
      get :edit, id: current_user.id
      expect(response).to be_success
    end
    it "permits PUT#update on the self" do
      put :update, id: current_user.id, user: { username: "My Name" }
      expect(response).to redirect_to(current_user)
    end
  end

  describe "when an admin" do
    let(:current_user) { FactoryGirl.create(:user, :is_admin) }
    before do
      sign_in current_user
    end
    it "permits GET#index" do
      get :index
      expect(response).to be_success
    end
    it "permits GET#show" do
      get :show, id: user.id
      expect(response).to be_success
    end

    it "permits GET#edit" do
      get :edit, id: user.id
      expect(response).to be_success
    end
    it "permits PUT#update" do
      put :update, id: user.id, user: { username: "My Name" }
      expect(response).to redirect_to user_path(user)
    end
  end

end
