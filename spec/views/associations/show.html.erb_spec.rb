require 'rails_helper'

RSpec.describe "associations/show", type: :view do
  before(:each) do
    @association = assign(:association, Association.create!(
      :user => nil,
      :user => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
