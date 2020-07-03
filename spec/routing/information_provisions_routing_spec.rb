require "rails_helper"

RSpec.describe InformationProvisionsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/information_provisions").to route_to("information_provisions#index")
    end

    it "routes to #new" do
      expect(get: "/information_provisions/new").to route_to("information_provisions#new")
    end

    it "routes to #show" do
      expect(get: "/information_provisions/1").to route_to("information_provisions#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/information_provisions/1/edit").to route_to("information_provisions#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/information_provisions").to route_to("information_provisions#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/information_provisions/1").to route_to("information_provisions#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/information_provisions/1").to route_to("information_provisions#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/information_provisions/1").to route_to("information_provisions#destroy", id: "1")
    end
  end
end
