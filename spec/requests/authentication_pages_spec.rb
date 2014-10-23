require 'rails_helper'

describe "Authentication" do
  subject { page }

  describe "signin page" do
    before { visit signin_path }

    it { should have_title("Todo | Sign In") }
    it { should have_selector('h1', "Sign In") }

    describe "signin POST /sessions" do
      before do
        User.destroy_all
        @user = FactoryGirl.create(:user)
      end

      context "valid info" do
        before do
          fill_in "Email",    with: @user.email
          fill_in "Password", with: @user.password
          click_button "Sign In"
        end

        it { should have_link('Profile', href: user_path(@user)) }
        it { should_not have_link('Sign In', href: signin_path) }
        it { should_not have_link('Sign Up', href: signup_path) }
      end

      context "invalid info" do
        before do
          click_button "Sign In"
        end

        it { should_not have_link('Profile', href: user_path(@user)) }
        it { should have_link('Sign In', href: signin_path) }
        it { should have_link('Sign Up', href: signup_path) }
      end
    end
  end

  describe "authorization" do
    describe "for non-signed in users" do
      User.destroy_all
      let(:first_user) { FactoryGirl.create(:user, email: "first@email.com") }
      let(:second_user) { FactoryGirl.create(:user, email: "second@email.com") }

      describe "when attempting to visit a protected page" do
        before do
          visit user_path(second_user.id) # currently protected
          fill_in "Email", with: first_user.email
          fill_in "Password", with: first_user.password
          click_button "Sign In"
        end

        # describe "after signing in" do
        #   it "renders the desired protected page" do # Friendly Forwarding
        #     expect(page).to have_title("Todo | #{second_user.name}")
        #   end
        # end
      end
    end
  end
end
