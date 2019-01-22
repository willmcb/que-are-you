require 'rails_helper'

RSpec.describe "associations/index", type: :view do
  before(:each) do
    assign(:associations, [
      Association.create!(
        :user => nil,
        :user => nil
      ),
      Association.create!(
        :user => nil,
        :user => nil
      )
    ])
  end

  it "renders a list of associations" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
