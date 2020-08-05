require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = create(:user)
  end

  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should validate_presence_of(:name) }
  it { should validate_length_of(:name).is_at_most(User::NAME_MAXIMUM_LENGTH) }
  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email) }
  it { should respond_to(:authenticate) }

  describe "with a of password that s too short" do
    before { @user.password = @user.password_confirmation = "a" * 5 }
    it { should be_invalid } 
  end

  describe "return value of authenticate method" do
    before { @user.save }
    let(:found_user) { User.find_by_email(@user.email) }

    describe "with valid password" do
      it { should == found_user.authenticate(@user.password) }
    end

    describe "with invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid") }

      it { should_not == user_for_invalid_password }
      specify { expect(user_for_invalid_password).to be false }
    end
  end 

  describe "email address with mixed case" do
    let(:mixed_case_email) { "Foo@ExaAple.com" }

    it "should be saveet all lower_case" do
      @user.email = mixed_case_email
      @user.save
      expect(@user.reload.email).to eq(mixed_case_email.downcase)
    end
  end

  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@goo,com user_at_foo.orb example.user@foo doo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        expect(@user).not_to be_valid
      end
    end
  end

  describe "when email format is valid" do
    it "should be valid " do
      addresses = %w[user@user.com A@sdd.s.org first.last@email.com]
      addresses.each do |valid_address|
        @user.email = valid_address
        expect(@user).to be_valid
      end
    end
  end
end
