require 'rails_helper'

RSpec.describe "companies/index", type: :view do
  before(:each) do
    assign(:companies, [
      Company.create!(
        name: "",
        meta_description: "",
        about: ""
      ),
      Company.create!(
        name: "",
        meta_description: "",
        about: ""
      )
    ])
  end

  it "renders a list of companies" do
    render
    assert_select "tr>td", text: "".to_s, count: 2
    assert_select "tr>td", text: "".to_s, count: 2
    assert_select "tr>td", text: "".to_s, count: 2
  end
end
