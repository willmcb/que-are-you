require 'rails_helper'


RSpec.describe "Add new associate" do
  include ActionView::Helpers
  before :each do
    @test_user = create(:user)
  end

  describe "add associate" do
    it "Add associate and see their id on list" do
      login
      visit '/associations'
      click_link "Associate?"
      fill_in "Associate", with: 1
      click_button "Associate!"
      expect(page).to have_content "You are associated with user 1, congrats"
    end
  end

  def login
    visit '/login'
    fill_in 'Email', with: @test_user.email
    fill_in 'Password', with: 'password'
    click_button 'Log in'
  end
  
end
