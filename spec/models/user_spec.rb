# Users can sign up for the site with a valid name and email

require 'spec_helper'

describe User do
  before { @user = User.new(name: "Gerry Pass", email: "rgpass@gmail.com",
                            password: "foobar", password_confirmation: "foobar") }

  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should be_valid }

  describe "validations" do
    describe "name" do
      context "not present" do
        before { @user.name = " " }
        it { should_not be_valid }
      end

      context "too long" do
        before { @user.name = "a" * 51 }
        it { should_not be_valid }
      end
    end

    describe "email" do
      context "not present" do
        before { @user.email = " " }
        it { should_not be_valid }
      end

      context "too long" do
        before { @user.email = "a" * 201 }
        it { should_not be_valid }
      end

      context "correct format" do
        it "is valid" do
          addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
          addresses.each do |valid_address|
            @user.email = valid_address
            expect(@user).to be_valid
          end
        end
      end

      context "incorrect format " do
        it "is invalid" do
          addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                       foo@bar_baz.com foo@bar+baz.com foo@bar..com]
          addresses.each do |invalid_address|
            @user.email = invalid_address
            expect(@user).to_not be_valid
          end
        end
      end

      context "mixed case" do
        it "is saved as lowercase" do
          mixed_case_email = "fooBAR@exaMPlE.coM"
          @user.email = mixed_case_email
          @user.save
          expect(@user.reload.email).to eq mixed_case_email.downcase
        end
      end

      context "when already taken" do
        before do
          user_with_same_email = @user.dup
          user_with_same_email.save
        end

        it { should_not be_valid }
        
        User.destroy_all
      end
    end
  end
end