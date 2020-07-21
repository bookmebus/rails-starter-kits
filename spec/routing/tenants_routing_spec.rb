require "rails_helper"

RSpec.describe TenantsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/tenants").to route_to("tenants#index")
    end

    it "routes to #new" do
      expect(get: "/tenants/new").to route_to("tenants#new")
    end

    it "routes to #show" do
      expect(get: "/tenants/1").to route_to("tenants#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/tenants/1/edit").to route_to("tenants#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/tenants").to route_to("tenants#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/tenants/1").to route_to("tenants#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/tenants/1").to route_to("tenants#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/tenants/1").to route_to("tenants#destroy", id: "1")
    end
  end
end
