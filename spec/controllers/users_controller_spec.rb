require 'spec_helper'

describe UsersController, type: :controller do
  describe "GET new" do
    it "renders :new" do
      get :new
      expect(response).to render_template(:new)
    end

    it "assigns new User to @user" do
      get :new
      assigns(:user).should be_a_new(User) # confirm that @user = User.new
    end
  end

  describe "POST create" do
    context "valid attributes" do
      it "creates user" do
        expect{
          post :create, user: FactoryGirl.attributes_for(:user)
        }.to change(User, :count).by(1)
      end

      it "redirects to :show" do
        post :create, user: FactoryGirl.attributes_for(:user)
        last_user = User.last
        expect(response).to redirect_to(user_path(last_user.id))
      end
    end

    context "invalid attributes" do
      it "does not create user" do
        expect{
          post :create, user: FactoryGirl.attributes_for(:user, email: " ")
        }.to_not change(User, :count)
      end

      it "re-renders :new" do
        post :create, user: FactoryGirl.attributes_for(:user, email: " ")
        expect(response).to render_template(:new)
      end
    end
  end

  describe "GET show" do
    User.destroy_all
    
    let(:user) { FactoryGirl.create(:user) }

    it "renders :show" do
      get :show, id: user.id
      expect(response).to render_template(:show)
    end

    it "assigns requested user to @user" do
      get :show, id: user.id
      # Assigns @user to eq user that we defined on line 5
      assigns(:user).should eq(user)
    end
  end
end
