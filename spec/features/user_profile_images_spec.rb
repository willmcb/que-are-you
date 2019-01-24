require 'rails_helper'

RSpec.describe "Profile images" do

	before :each do
    @test_user = create(:user)
  end

  describe "Default profile image" do
    it "gives user a default profile image" do
		 login
		 visit("/users/#{@test_user.id}")
     expect(page.find('img')['src']).to have_content 'Default_profile_image.jpg'
    end
  end
end
