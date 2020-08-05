require 'rails_helper'

RSpec.describe "StaticPages", type: :system do
  before do
    driven_by(:rack_test)
  end
  subject { page }

  describe "signup" do
      before { visit signup_path }
      let(:submit) { "Create User" }
      it { should have_selector("h1", text: "Sign up") }
      
      describe "with invalid information" do
        it "should not create a user" do
          expect { click_button submit }.not_to change(User, :count)
        end
      end

      describe "with valid information" do
        before do
          fill_in "Name", with: "Exaple User"
          fill_in "Email", with: "user@example.com"
          fill_in "Password", with: "osman"
          fill_in "Confirmation", with: "osman"
          click_button submit 
        end
      end
  end

  describe "profile page" do
      let(:user) { create(:user) }
      before { visit user_path(user) }

      it { should have_selector("h1", text: user.name) }
  end
end