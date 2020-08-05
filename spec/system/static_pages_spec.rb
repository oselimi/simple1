require 'rails_helper'

RSpec.describe "StaticPages", type: :system do
  before do
    driven_by(:rack_test)
  end

  subject { page }
  describe "Home page" do
    before { visit root_path}
    it { should have_selector("h1", text: "Simple App") }
  end

  describe "Help page" do
    it "should have content 'Help' " do
      visit '/help'
      expect(page).to have_selector("h1", text: "Help")
    end

  end

  describe "About page" do
    it "should have content 'About'" do
      visit '/about' 
      expect(page).to have_selector("h1", text: "About Us")
    end 
  end
end
