require "spec_helper"

RSpec.describe "Authenticate", type: :system do
    before do
        driven_by(:rack_test)
      end
    
    subject { page }

    describe "signin page" do
        before { visit signin_path }
        
        it { should have_selector("h1", text: "Sign in") }
    end 

    describe "witg valid information" do
        let(:user) { create(:user) }
        it "login in " do
            fill_in "Email", with: user.email 
            fill_in "Password", with: user.password 

            click_button "Sign in"
        end
        
    end
end