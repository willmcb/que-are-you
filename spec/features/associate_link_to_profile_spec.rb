require 'rails_helper'


RSpec.describe "Associate link to profile" do
  include ActionView::Helpers

  before :each do
    @test_user = create(:user)
  end

  describe "Click associate" do
    pending "clicking on associate shows their card" do
      login
      visit "/associations"
      click_link 'Associate?'
      click_button 'Submit'
      click_link "testuser testlastname's card"
    end
  end

end
