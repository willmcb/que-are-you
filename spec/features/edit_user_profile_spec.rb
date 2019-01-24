require 'rails_helper'


RSpec.describe "Edit profile page" do
  include ActionView::Helpers

  before :each do
    @test_user = create(:user)
  end
  describe "View profile" do
    it "allows user to edit their profile page" do
      login
      visit "/users/#{@test_user.id}"
      click_link 'Edit details'
      fill_in 'Firstname', with: 'Will'
      fill_in 'Job title', with: 'Chief will officer'
      fill_in 'Company name', with: 'willcorp'
      fill_in 'Biography', with: 'new bio stuff'
      click_button 'Submit'
      expect(page).to have_content 'Will'
      expect(page).to have_content 'Chief will officer'
      expect(page).to have_content 'willcorp'
      expect(page).to have_content 'new bio stuff'
      expect(page).to have_content 'testlastname'
    end
  end

  def login
     visit '/login'
     fill_in 'Email', with: @test_user.email
     fill_in 'Password', with: 'password'
     click_button 'Log in'
  end
end
