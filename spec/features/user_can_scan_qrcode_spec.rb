require 'rails_helper'

RSpec.describe "QR scanner" do
  let(:must_be_logged_in_message) { "You must be logged in to access this page." }
  before :each do
    @test_user = create(:user)
    login
  end

  it "shows a preview" do
    visit '/'
    all('a', text: 'Scan QR code')[1].click
    expect(page).to have_current_path '/associations/new'
  end
end
