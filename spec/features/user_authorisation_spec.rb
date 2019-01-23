require 'rails_helper'

RSpec.describe "User authentication" do
  let(:must_be_logged_in_message) { "You must be logged in to access this page." }
  before :each do
    @test_user = create(:user)
  end

  describe "User authorisation" do

    it "stops a user from viewing their profile unless they are logged in" do
      visit 'users/1'
      expect(page).to have_content must_be_logged_in_message
    end

    it "stops a user from editing their profile unless they are logged in" do
      visit 'users/1/edit'
      expect(page).to have_content must_be_logged_in_message
    end

  end
end
