require 'rails_helper'

RSpec.describe "tenants/index", type: :view do
  before(:each) do
    assign(:tenants, [
      Tenant.create!(),
      Tenant.create!()
    ])
  end

  it "renders a list of tenants" do
    render
  end
end
