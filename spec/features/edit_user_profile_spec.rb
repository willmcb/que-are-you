require 'rails_helper'

RSpec.describe "Edit profile page" do
  before :each do
    @test_user = create(:user)
  end
  describe "View profile" do
    it "allows user to edit their profile page" do
      login
      visit "/users/#{@test_user.id}"
      click_link 'Edit'
      fill_in 'First name', with: 'Will'
      click_button 'Submit'
      expect(page).to have_content 'Will'
    end
  end

  def login
     visit '/login'
     fill_in 'Email', with: 'dave@test.com'
     fill_in 'Password', with: 'password'
     click_button 'Log in'
  end
end
