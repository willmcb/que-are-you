require 'rails_helper'

RSpec.describe "Profile images" do

  describe "Default profile image" do
   it "gives user a default profile image" do
     signup
     expect(page.find('img')['src']).to have_content 'Default_profile_image.jpg'
   end
  end
end
