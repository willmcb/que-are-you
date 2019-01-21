require 'rails_helper'

RSpec.describe "User authentication" do
  before :each do
    @test_user = create(:user)
  end

  describe "Sign up" do
   it "allows a user to sign up" do
     login
     visit "users/#{@test_user.id}"

     expect(page).to have_content @test_user.firstname
     expect(page).to have_content @test_user.lastname
     expect(page).to have_content @test_user.email
   end
  end

  def login
     visit '/login'
     fill_in 'Email', with: 'dave@test.com'
     fill_in 'Password', with: 'password'
     click_button 'Log in'
  end
end
