require "rails_helper"

RSpec.describe EventDetailsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/event_details").to route_to("event_details#index")
    end

    it "routes to #new" do
      expect(get: "/event_details/new").to route_to("event_details#new")
    end

    it "routes to #show" do
      expect(get: "/event_details/1").to route_to("event_details#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/event_details/1/edit").to route_to("event_details#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/event_details").to route_to("event_details#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/event_details/1").to route_to("event_details#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/event_details/1").to route_to("event_details#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/event_details/1").to route_to("event_details#destroy", id: "1")
    end
  end
end
