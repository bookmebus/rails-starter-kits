require 'rails_helper'

RSpec.describe "companies/edit", type: :view do
  before(:each) do
    @company = assign(:company, Company.create!(
      name: "",
      meta_description: "",
      about: ""
    ))
  end

  it "renders the edit company form" do
    render

    assert_select "form[action=?][method=?]", company_path(@company), "post" do

      assert_select "input[name=?]", "company[name]"

      assert_select "input[name=?]", "company[meta_description]"

      assert_select "input[name=?]", "company[about]"
    end
  end
end
