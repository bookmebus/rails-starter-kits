require "rails_helper"

RSpec.describe Quote::SubmissionsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/quote/submissions").to route_to("quote/submissions#index")
    end

    it "routes to #new" do
      expect(get: "/quote/submissions/new").to route_to("quote/submissions#new")
    end

    it "routes to #show" do
      expect(get: "/quote/submissions/1").to route_to("quote/submissions#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/quote/submissions/1/edit").to route_to("quote/submissions#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/quote/submissions").to route_to("quote/submissions#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/quote/submissions/1").to route_to("quote/submissions#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/quote/submissions/1").to route_to("quote/submissions#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/quote/submissions/1").to route_to("quote/submissions#destroy", id: "1")
    end
  end
end
