require 'rails_helper'

RSpec.describe "User login redirects to /" do
  before :each do
    @test_user = create(:user)
  end

  describe "User login" do

    it "When users logs in they are redirected to index page" do
      login
      expect(page).to have_current_path '/'
    end
  end
end 
