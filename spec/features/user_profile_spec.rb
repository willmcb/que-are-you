require 'rails_helper'

RSpec.describe "Profile page" do
  before :each do
    @test_user = create(:user)
  end

  describe "View profile" do
   it "allows user to view their profile" do
     login
     visit "users/#{@test_user.id}"
     expect(page).to have_content @test_user.firstname
     expect(page).to have_content @test_user.lastname
     expect(page).to have_content @test_user.email
     expect(page).to have_content @test_user.company_name
     expect(page).to have_content @test_user.job_title
     expect(page).to have_content @test_user.biography
   end
  end

  def login
    visit '/login'
    fill_in 'Email', with: @test_user.email
    fill_in 'Password', with: 'password'
    click_button 'Log in'
  end
end
