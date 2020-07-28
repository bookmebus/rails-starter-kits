require 'rails_helper'

RSpec.describe "tenants/new", type: :view do
  before(:each) do
    assign(:tenant, Tenant.new())
  end

  it "renders new tenant form" do
    render

    assert_select "form[action=?][method=?]", tenants_path, "post" do
    end
  end
end
